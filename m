Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB2CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWnm-0001er-Sf; Tue, 29 Sep 2026 08:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWnS-0001UP-4L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:19:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWnP-00034z-U7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:18:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCDwOS1491572
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FIIxQY0DKkpd5d1Pu1aYAbPDsQs3swAKFb9g30h4g6c=; b=WgLbYV6v53NJaJWF
 NXYEO4c0DzEhJBVkbAckHXzZ2msHD9JeEEWIY/wAT9i1J8rEtJvFC8NwNirWe8gz
 CPtNvLj/q9IXzpa0l4XWDM3IBgQbQjF6ZjjZn/nZPzZQ+iJpe3UW+IxBjibwymBC
 s31N1r8GyJAg2YXrSXZ03ru1bVcbjAXbNxcVhwh0iGG1Vu+1j6Q7+02N2WaRYma8
 psenXnFQoWRF5r4bSEJrbxriGTIO3TbnPG+/lMXJhGQbp7UDEo2+zXFP0e8YulRt
 dJ5YT+hpRW4rf6WFDUj/84/KJmLMbHF2WIT89nm3cz7KvJOoJKVgVI+f0eWN5unz
 3Rr9Ug==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4rwar-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:18:54 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7909e307799so3902124137.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684333; x=1791289133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FIIxQY0DKkpd5d1Pu1aYAbPDsQs3swAKFb9g30h4g6c=;
 b=UZT3lGRmKwIlJqEbwTSAQM2Mr+/V95iuTB0Szr/rtT2padjHBNFcwxdtHZQYlSAT0y
 dqWG0IHmGa3izA0DZ2LdyQ3zQUTlTcMgf+8NHR+WClxnagiBpEA/bahoGagnGaA2oFLw
 OWghLDMap+5erTBVkSNqc+4/NlnZ7mKQck/re704m0+b5AqFwZJhYCv6r1Kys4tIxecG
 w8I0trC5Lp0CGahe6GLD9fR/w484FpploaOLayuT/vJDjdg3S2MAMeloiyKLT/OXP9jc
 hMgyPu+8Ef2FVA0H4Nn1rrp+wD0CewdYERaMyPw+ETSDQwU0rM67ASrQprdt+Y/6EHvE
 HJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684333; x=1791289133;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FIIxQY0DKkpd5d1Pu1aYAbPDsQs3swAKFb9g30h4g6c=;
 b=GBUXI2i7B6DD2F+gFP6zHiXAlOkyz3CBZfEMSesH9DnkSsMlBbZY4OWBrRiB1Z1cxf
 MPCwTT1P1luhNNVTUwtyHgGj8imHC5gzRxlpdPLF3Rlz6NEhQ9gsK3hTeVNipNQRVpoh
 +Enki3v+4TZufWwMq0tjGELTzQsmIuodbiyM39YyqLGW1nCazroHps4pWGBgSVzK6wDM
 /Tfrszkj+CquV3wPClrBua5rR+xXvR+qA9cYqLSXRczQ78sd/nz8HAB02ZryAoqma1ao
 JXOCLyESEpQu654LPSp3vpH8d8XRYlQig8UGpKux/0j8MpNz/eq35JpRrjxnEIDUmthY
 DvHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzalmZiM3LIw72QGclXvhUKoqFg55oFJglkgu//A640dviy3J89J6/WNCX0DWwQYr0I8GuZu1eXxGkp@nongnu.org
X-Gm-Message-State: AFq9FYJFl8Ok6JkQX4ESe7lorqwwzc/SRPg2m+sIKkEr5oOkBMStD50g
 pyEmJS1MTx2J5ZOh0gvdsqAZ6CGV8GT4A0iZnm1TkZg08d262ZqUH2sh1x6S+ztR+1JpLoSTVr+
 fa8aiz5u4jKkO/JdYL13QPtNdIJGlJbhPbmPcRlhsnlTxsJl1SxmeobtzDQ==
X-Gm-Gg: AYBFou16/ZcJUZ4Qvnuf3+sbA3D7ONnt/l5+uQH/1zCL4T+naaEip7UkFke6QaJmhIW
 SBF6lTI92haZ8Z+eiqzH6zqUgr3yuYk/5pfJHYbj9orZW7hNeB+nEcYmh4HRNJsbSAuKhlIpmRV
 HvUPplGmY9ZG3ZPdUGbN+noGUqisE3eg3LTFeXGZIdRv9gPKVLVmmNPc+GQ0RJbb7pevnzT2B/1
 1S2MaEJTL2uCG8ehtwm3wke+B+15fnqf6FtJbcTeN4jFlWvEsiMEOJpXCMZEkaQRA+nkX6rNfaN
 hWPB7GPLRv5ldWTyp8GxtbiPFeWc4UsHPQbB+Hz+K3Qyc1DTRfEnRanySab7E3g6p5HzP8WAC6D
 Z4ipVQu8ZDuPWEgOw/bWJInohxaJ1g4n6Nw==
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id
 ada2fe7eead31-7b34af062e2mr3433909137.21.1790684333262; 
 Tue, 29 Sep 2026 05:18:53 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id
 ada2fe7eead31-7b34af062e2mr3433896137.21.1790684332826; 
 Tue, 29 Sep 2026 05:18:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af502cd22sm3753000f8f.13.2026.09.29.05.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:18:52 -0700 (PDT)
Message-ID: <dbc93e3c-77da-449f-b7c9-83f54ce49016@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/42] hw/arm/Kconfig: Select missing UNIMP in config
 FSL_IMX8MM
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-19-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-19-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX21AykXfWLYNR
 t0s2pz1iBenhvmGSCH7vg+PNHVV6kT5h6cPP45e9Xo8sln0kaorLkITl8tic7YTROJEr+595l2/
 jHIoHCFQ2Nv0/5A/osljTZPNZ5sJnVU=
X-Proofpoint-GUID: UMNuEv1Jx3m6wsH4JX5DZnkPI95PW5an
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abbacae cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hGsxVD3Pt4E_wTTo8hUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: UMNuEv1Jx3m6wsH4JX5DZnkPI95PW5an
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX6pibeYjuhX6A
 nBzQvs+nUHklIvFhmtNVJKmJtQ0FuzaS+x65rtA23Kkw06V7GcWHSAhN6LmPHUJGHmo4/qRnEVJ
 5ltuD3WS8siiI66u4wYeCOtrlMR4U2aTZruhPxcJ3z00stTBaFQ3PDM8Cf1sFQtSe6oQvCCfaUB
 sjnX/WmcSXrtLZze2RFtI7Ja6kkRCOoHpeweA1itB66ek63+/9wBOQYp2Nu77aQxdThbtELmZm5
 Hf3D7ZkdlhBZ1cd5LRGPUDckn/rznGtLp6DHNWlaibeChrj9aW9p+h0UqYy64QMexAUGWUT34HV
 oClumw3oqBwsk2+PiPYGWFiJbWB+/svE7lNIOYgodryqsoG8LF145r9MOXZP02xY+Im1akDIUeu
 UopN5JfF7jRmWKT89ZwsFKeZW37lii8tAXD1bLMcytqgPq61VZeZ9J+7DZ2lRiaYeitfcA5j4BZ
 yVH/W2t1RzU8ekDFi6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290048
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> TYPE_FSL_IMX8MM models the whole address space by representing
> unimplemented devices with TYPE_UNIMPLEMENTED_DEVICE. This means that
> UNIMP needs to be selected by config FSL_IMX8MM which is currently
> missing. Fix that.
> 
> Fixes: 7bcd1f30bc83 ("hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

