Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99379C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2pO-0004vp-5c; Wed, 12 Aug 2026 02:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu2pL-0004uO-Ez
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:52:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu2pJ-0007Oj-P8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:52:39 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C627YM3506010
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OP7RkG3PhQjtgbdqoWeWI88hg4MB/HKNEH5QP8YuzwQ=; b=aCluXfqNpeSrJaRj
 VoGyu62r5C59ojf4fvGkJDiRdeFEC68EvtDcuNO4KCNKKG8md5alupkPMYuiccxZ
 FNAswf0C8cdg+SebDW24WsxB5VnVKSYjmd6RJRWr/1iDr6GoFqN5gJJNuZR43tsM
 oW5ICr1UHJ2Ecp8OfbR1EtJHnjH76HvGywj1fHGKoXyvZlvXMem/zgbOX1P+ubUs
 aNe5ZxtxmupzgvnOloazdG3FvDdaYJ4mrquYSljsXM353Rhf8VlNnsuvlRsnMWRH
 CPb2+tmpNDbX9iyhtxcW2qF31yWIMf4uzXp8ilPmOdSYQnnw8ZJWjF39+A8vx1D6
 0pgIHg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g08j5jhhw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 06:52:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5276aa86d00so7413661cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786517551; x=1787122351; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OP7RkG3PhQjtgbdqoWeWI88hg4MB/HKNEH5QP8YuzwQ=;
 b=VwkG+5j70mhotZbMFS5g9k1U6O91VlJnW41sYTae7OtfmBH4rA2IS0cGPeZOErOE0o
 C6MTbmYEhEnMuNqhR/+8+PBAigIE0bvx/hdzd/NFob2PHT0UKNekNRQ7a8+ugFK56Txf
 ekNY3YVkYhju2Ddu3qx76FDCGS3d7vuRrXA34YN+QpCNSIh7+uxKVFM6/M96bsUQ5Uht
 5P/8/WMJyPjXPaICdcUfmj4TZOeFG+5MsjbwX3wMz9mQdrkycmHkW2uijeC9+iCYILpc
 KAEczDoLoK4ML+eyOtQR+xWAF9iBuxlGGa6B396zmWrbTrBCGqw2D2HdjW7hF+N7s4pk
 hiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786517551; x=1787122351;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OP7RkG3PhQjtgbdqoWeWI88hg4MB/HKNEH5QP8YuzwQ=;
 b=a0sSESF1yGAyCug3ywd7ItZrfCHtURMO5sIz7fpGmA+vsXm1JNFcU+7Dt22eA++JY6
 0T29jlmWAa6tA59ENj4952a4YC65RUO154chp9lehesNR3++Z8rATV9S1Jdrj8Mwgd9Z
 /xq2HLmf9OLxizo7zSdKy1GB0wxo4zuUF7CiQuLcVuxKLuSco6XvxqIitRAMEZg3nBqa
 5Cv5LWWtXqjML9FVpbiS8tr7ACxf+XEpzWiobXmKzLmmrWBtizjsLGYap6aThnGtWaol
 FHJZq6gGXeTsW6UULwLEe7UXL+HINg/4sqjhPIZGz0NWymXJwxgFTYF7byCnRH2TWWgQ
 tUkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/guNX6qEA2Ck59vjYTBnLXVHT+cdB03xfX/afNBTvORhGNphKcpwQPl1FsLxQSzyqv+cKju/VSXhC@nongnu.org
X-Gm-Message-State: AOJu0YzMbRsNYqFqISVwfTC9iYzgTulN+MTGBB00IEwOAHyG01tdFA2F
 k7IEdJiYVLmJDQkvoByFoYyAESGvm1ZcH9DCtJPaKO0oyNx5yg7cesQlC60LPvRgfQbNzhf4DAO
 oXeGBJ3KnH9PYvEtJNx1Ng0JIh3Qcf+rb8jvZYQZlMiu3X3sx4VRgZrd/gQ==
X-Gm-Gg: AR+sD11v81rppGh0mFLlBZP+VPLcn7GzM1j/y3BuU9zfDvLNL+xF0BMNFQJi2cBy0ui
 /CZ3klFc1gaVbnnAaf920R/p+D/EWl+byPd2WicCq1Z9+h2K5OtAyoyHQ9nV6166GfYSKl9AjKM
 bBx8YuS2KDUjxWhufnv+tlyZFJdV0MZODvbLTDBwFxrTfcCbgU+dwhJwFK+c/Y1ktxMglNDfrZA
 a9wA2qr9QhMOokns5owZ1mVoo1wkG0xnfkA7wi1IFIyKpEv/JT5vWls8BRnLzEBAfhSDve37Dvd
 3yBmstrBwAPFNTiWLww/OoclgFd84aawR5YlOS27Q9eKkp4VST2ElPFIxWwYWS0F2SDLARA2Ytn
 2qz/nYbUdBRU7GZdj2EGmTqXGYVb/eJRbhxo=
X-Received: by 2002:a05:622a:408f:b0:51c:1291:e68c with SMTP id
 d75a77b69052e-52d6482ef00mr24203811cf.30.1786517551649; 
 Tue, 11 Aug 2026 23:52:31 -0700 (PDT)
X-Received: by 2002:a05:622a:408f:b0:51c:1291:e68c with SMTP id
 d75a77b69052e-52d6482ef00mr24203531cf.30.1786517551272; 
 Tue, 11 Aug 2026 23:52:31 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c98d264sm25714185e9.9.2026.08.11.23.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 23:52:30 -0700 (PDT)
Message-ID: <43d549be-b2f1-474c-85c5-06891c3b9cae@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 08:52:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.2 machine
 anymore
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>, Fam Zheng <fam@euphon.net>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260811183144.190135-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811183144.190135-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1MyBTYWx0ZWRfXx463yocH3hqz
 tIkgp8gKBXqbuJGM+XHkbmwMuvoXNQlXQWiOObkPVbN/IwYrGHnU0RtuRRwquomJUKqYhL7jfzu
 T5eb5SeKXHEwnBwicgRzP13F02WvTJs=
X-Authority-Analysis: v=2.4 cv=evHvCIpX c=1 sm=1 tr=0 ts=6a7c1830 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=D5gR-Qcz-_NL_RVrCq8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: MasXO3ifxJyVuTSg0STVysuPdG6kRtI5
X-Proofpoint-ORIG-GUID: MasXO3ifxJyVuTSg0STVysuPdG6kRtI5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1MyBTYWx0ZWRfXyv3cQy/j+Q3D
 B13Ju3YN/nfwI71odCqFlEdaAdyu/0KUBoji0Y9IA39sGnyiY6Xhmu7PIMY86rLOqOwfVfaC8HT
 aRZq3QHAwNUUMBJ+n0kpAaxAhhHWNX+VDstBSZ1D+td5/hGNKJDjZfS8JqXklHvYemsLLkMck0c
 nJr2CS2XnD0h4Nl82LCVd2pXVPSBNdCLwqljzGKqeZg5wUgwILi2JNjTdRrAf5Gx3sZBP1pb7wx
 niSpkSHr5oG4fX0EuEJ1xm+nYaN7rds5zQXXwvQbXcGe2205BUJdMWG6G8XRp/j6yrtZjbfhSLO
 1NFsf/jX+KdLkkXfwBnZcg9Dzhiq+zM5hB+hHtmI/4mTCE/lcNabiEbhFLQced9CS8OEPelx8/3
 ZEXRy9HGYKlFJt6NElu4guzottzfVHEi4weEGFeFoueujKsQwCLDgEfIXQZnOCqxa0e3WDdLqXH
 LWJZrf3tBUFo/VtatmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120053
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/8/26 20:31, Stefan Hajnoczi wrote:
> As of QEMU v11.1.0, the v5.2.0 machines are not usable anymore.
> 
> Use the latest x86 q35 machine instead, otherwise we get:
> 
>    $ qemu-system-x86_64 -M pc-q35-5.2
>    qemu-system-x86_64: unsupported machine type: "pc-q35-5.2"
>    Use -machine help to list supported machines
> 
> See commit a35f8577a07 ("include/hw: add macros for deprecation
> & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> cope with dev/rc versions in deprecation checks") for explanation
> on automatically removed versioned machines.
> 
> This commit message is taken from commit 9eef3854d309 ("tests/qtest: Do
> not use versioned pc-q35-5.0 machine anymore") by Philippe Mathieu-Daudé
> <philmd@linaro.org>.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tests/qtest/fuzz-virtio-scsi-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

