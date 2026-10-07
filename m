Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB22CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESkm-00066q-JO; Wed, 07 Oct 2026 10:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESk9-0005h0-BA
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:35:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xESk2-0001Vq-B7
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:35:36 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697DJV3Z4056425
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 14:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yAb3aDa6pNn12U0jAsxuwpZv8YSlo8HlDYthoV56XTA=; b=HOzj6Oxfd8RPStIX
 5TNFxiRyZVkQxj+mtxqpqtHExkmUSiWOddvnn6izQlL8r3BBEwn6S7YskWugl6Vi
 YXY+Jsc0TMfbYBKfxy0Q1a3hACfX9gjR4lqDOO9v3ep0Q/h7ojFRJPq9F53T9cfp
 rZZrgOsm54u2XgB3RcMSw0MmJurOvddwoLjY4gKrB7LkaZxYHPqIJtDimXF9oehf
 g2aXSGkqAhtrQ6rkB3hyMf7jEt8v9uYQrQ17SRxobsZ3p4++rpsOXTW6BfZOxyGZ
 FYY6WXivvqi0fsL9oI+v+gz8nfpPvHLJ1Hv+o/sco0Duw6CjGdkXTWTIUJyjo8FM
 RJIs7A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5pv70978-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 14:35:32 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34e676375d9so4174589eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791383732; x=1791988532; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yAb3aDa6pNn12U0jAsxuwpZv8YSlo8HlDYthoV56XTA=;
 b=TRw03VPxFAVubsB1hnwpHnZ65+iiAea5BsseDx/RMULt4RMU0OVDHfFpZan1BFx6mN
 f9+WGjNclU0jo9Dz/Dq6JEXE9slFXnPULoXzatl3SLi4RZtdtbBjP6xf0Lqb00KrrAqz
 u/vnW5KG13cOFhJ1wN4g0FfK6dPDfUv7NBJMPId/NtyQIXP6PacPLFuCJ3TpNgieB4qX
 20Ofh+/u8036xdfiBv+RfSIVOcy6PZCJmpURFbSUzBocmnkGwvNoUM4YiXcwCtPip4e/
 oGFWNrybtvymVtBUcpYmpXxIV4atbVk6RIDrmXdbgHnchJCraz8/5HelY0kM/LBhuBWN
 oSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383732; x=1791988532;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yAb3aDa6pNn12U0jAsxuwpZv8YSlo8HlDYthoV56XTA=;
 b=UJrLj+8jpb9zbqezZkXI+805olAHA6j2KABEbSpXBqc5BJX1Na12vl9ZUzU0HcBmyN
 ZUfwAl2ZDlboq4dVFDivu20tIWsLXFjpWoNmICFZHxoV/VCgeYj/t0CtS24Tn3aoWTyA
 fSZ7WGDznuY6vPp3tTinqLi27HzQ4Ay/EUGA7v25UF0NZr4ivqF8eZswKcsnK21WQ2YM
 fVNL20iQcvtFqwG0uD1cVkW9jvchBhrOF9TjUBORhvMliaNNAJHwiAgGdQYlOBHN2Lil
 rrloDhB+2+3xEnMJI5TFMCIQTuRsdnsE0GL7zV4Tc3LfKAkUHlQWeoKryh8s8uxnAzN6
 tK7A==
X-Gm-Message-State: AFq9FYKfPdc1OUOUaPonggeT9kxEyKYiPoKbc7nilssQTbj5WlFBE0ZD
 q7bNfOr5hVyTiMpwFkD9z+Ysdc+falBWEVACJ06FW+NEz6BEE7rAW2SfkDb3gBRg8xocEE65fn/
 QqFipxhKRtYc3nIgQYyX5ENcRFjeDdde5SxusypyKZOKmRdX69d5JGxcGTcv6IZm4sA==
X-Gm-Gg: AYBFou0769Zc4htZXDe4mGXco37iIcj0fFUCHaoqjzqtb6YfC1CgIfs/7zGD6SoVPO/
 0eXd5v7rtfq1+4UOMbQg0g3Lfu033SJV4PA9aF4vW9YzstWoL3z0mi4rKhAQrNqWQGsyvWMq6Dp
 yreLqxuJ33NA45ybQHeVCMfD5vesLGV9fFepoAYkP5HnZ5290WKBCFjAuNADgLhZ/KgNsZ56Lg+
 q4EdDvCzsP+G/vJrv86k+CfAl3x334kODUmg9dfl+p0yKx9NSeefqjy7U5GDiNsI+CVkqfKE5qU
 612wK/p8XvKuogFkuteWm4FsY9gY50m4fgvYDl98kqeo1SFdshvAv0gXWy6oyIImwMNLNQbepDn
 sdwswUzwj0hL3mRAGP4MBRZCfljWoET85eG4Ued9Q8Gvn2AOJinU5zEgIcpPo0wtn/MNgcg==
X-Received: by 2002:a05:7300:d513:b0:351:695d:c942 with SMTP id
 5a478bee46e88-351695df07dmr1648562eec.11.1791383732163; 
 Wed, 07 Oct 2026 07:35:32 -0700 (PDT)
X-Received: by 2002:a05:7300:d513:b0:351:695d:c942 with SMTP id
 5a478bee46e88-351695df07dmr1648501eec.11.1791383731405; 
 Wed, 07 Oct 2026 07:35:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515afee963sm10107205eec.24.2026.10.07.07.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:35:30 -0700 (PDT)
Message-ID: <fc955c0c-cf85-428f-bec0-2426672aeff8@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 07:35:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add multi-target job
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfXy0A45TDNufRf
 IR7yP03vBUGp9MEnfDVzGeFk0oLA2Gh3CEZQM00dMuVc5hJ45JO6/DRiiFQbQ4+/PGsTf2UTWi5
 SUBRwv6rkTgni/RqQeLCJIL9GMjUQug=
X-Authority-Analysis: v=2.4 cv=J4I/fwnS c=1 sm=1 tr=0 ts=6ac658b4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=5RYVzw5aevVbmT0EGnoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: W9Jg9_rd1oedqOngQw1CNVdonsiGuSDW
X-Proofpoint-GUID: W9Jg9_rd1oedqOngQw1CNVdonsiGuSDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX3RCHRgWgth6N
 zjnj95h0D7Loc/1xbStxckgBUosB9IkWdFJ09Q/DJAciP7pUEMkt5kEguW/6OFsKzSHlFLzHegd
 2vTDvvmtbm+dWSkvjJAnNCFIpidtMDol3iEp41Gcfpa7f6bRD6BC8ZLIuMcSA9BqLgBnU+oWUIY
 uAcUch3wpxayEqvx50k5a1gvoZzvzrfKiylJh6sJVZMDPVr72AUnbdSIN2I8X/CoLKsZ/ZkUVfe
 hJGOA+RRrCblCsNt50ANtXZhLSW9gYSZ9Yazx7o8ZPC21LrUBoAo/fQVjIOun78Cbb/pN1Fa+zo
 +dos7pYcBaKNtv8Oi9E7FQzVdE9XLZCgQQTAf/lzqT3a61OzIwoO5rtJaJBWa44o/P2YrFtV2fM
 +wP0ilM9kQNNfW1K4SVXdbKNBdOtJFzjf2HCdQdNqs4B/K9/NTXXVBaMLY/A+z2A4PoWAvcvp5o
 J4ReX9RTr1MZtCOflvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/29/2026 11:33 AM, Pierrick Bouvier wrote:
> This check ensures we don't bring regression for all targets that can be
> linked together by building multi-target test. Also, running it ensure
> all QOM types are unique.
> 
> All compatible targets are automatically detected, so they don't need to
> be fed to ./configure.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

This was merged into master (faf92d98e399320836f0db9bdf192593a8b56a71).

Regards,
Pierrick

