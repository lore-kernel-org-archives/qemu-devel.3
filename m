Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422DFC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSEv-0001y7-7p; Thu, 16 Jul 2026 15:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSEn-0001to-E5
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:59:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkSEl-0000Mk-Sh
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:59:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJorW33864127
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EMhgrooHmwxlXg9yeZyIbycPQqjfvCOLGyLjbks4A4o=; b=mZpISV3N5XTMvcm5
 4Rif6bccdctCP8o1thS5tvUck5zK0vdhwj2NRNCFFgGqiodhmUq4M0QBbR5Da+0B
 Xtph5tvAKK6q5xJGM4CLOWRy1UOSm3tAgFpZWtHNIjCM77MoME8r12PzNDrqR1s/
 dVmblm7rzAXievfMjXxsBoKzYZCsSV3xSWxMYV7TrGFkYbIeMYTdDwZgz1CNHPWv
 p402h8ZurrRhet66me5z7D1kxxEZSEPP2l7ik7Q9O44f7cMvknBLVHH4ir5f6G/T
 PD8iYK5Cbb7Yktv/gBaKgURW/Vf9O0opD5Xy16r/u3dWkFuKTTBgdVwnYLUMVdaM
 gEO78Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu10b6sv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 19:59:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso2790282a91.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784231954; x=1784836754; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EMhgrooHmwxlXg9yeZyIbycPQqjfvCOLGyLjbks4A4o=;
 b=SnhWAMDFUBaYKhUD7qndsJhdIJ6weeEWenPF8diX+mtOGD9zQWYTiuhF5+M4sabbCe
 R3N4yC2CavciymMfbiw48wqNBy0xkZm5EcU9wV6cTeTF3rYwVMG/PA8XJRO1PYIn8RqN
 M75jhT9g3D9SxU6BHoRwK0aEsIVbcveRGY06lEQl0gRpIWi/zLketOAc9xU7Zwus5iHj
 /aAp7J80/hU0PlXuWanEkABnEcBN/zaXmk4EwRWgnXnI0VBiavkyU1Y4F8aDMEEHz5Iw
 A3ay6OzSXQekwWRtxkcmdWMRN28+R6hjUjmdsLADiuwap6DcjbgjEGjDIUGy96ieN6aH
 TOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231954; x=1784836754;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EMhgrooHmwxlXg9yeZyIbycPQqjfvCOLGyLjbks4A4o=;
 b=J0LzLlKubwZ4mZezFIxop3SDBCkGnqucVakJGxx2UQyH3BJ2GyFROc3Dsdec7SsRHE
 tzFQogBcqYAl3tm9Enpb2HmzXzqwOP8hvzLZbx6QgYgh4pod8I/lXTiBT6s00TuTVZ7o
 EykJKkUcfPK0Ci82NoQPKAW+eKZDJo4ATjisKq+4M33cXKgJIqeqUTSRcc+HdK94EWZ0
 o8x5l9MHMPKeTaWbGiaFpZo+BZ27iCpff3Wv2Tk4/MqlVOMRzzRuwCHqkHS+zj5j/NQG
 DWVWKt+prs8tcgcmRZsZW+ySmcR7PC5Qs8vZCWw4PvxdcbhYevUvsvZOIMQVmngkDYic
 2tYA==
X-Gm-Message-State: AOJu0YymN6YHvJGkdA+avRfwjIUguB4pStdhncMvbTpUKiWS20XmXdNW
 V4ic75nHEM1ncn1DXLPcoVDuFCHFIldiQzjv7asdrG/27NVTfKob3BgrkuqC5QXpgItLnuCVZRj
 SXUpMum1Zcf0Ez9dbjB6TIsrLMMz5tiMhT3+rpfhKuk0B/klOE8JkpucGfIXTFZMAzw==
X-Gm-Gg: AfdE7ckrXjb5SA25PKEDvKhb8XqPpWEB81jIzI5lhGNhjoIvp9NIYMwFSUoVR6hbD4n
 vLCA+NJi0L7p2YKbvFpfaOjSBe75jYAvm/xmvjB3zPEwjYreeo7sUw7NsG+WVwCNYvParrhUkE3
 jzUUE33NNHPsSrGQRG4UJIm9f1J9tCwP0z6IRMEaIm4dZHp7/ZEBPqnR9T3pOubQW+NwDZjiYbx
 hWl9Fr4xn1yMIvvwqXn3HwaWsHB5A9yD2DLsC+3FVCiM826oyZR4SRDy2V/Sa4bZ0j8E6SUQ6Aa
 Ml6Ht+oBDY7HbdzQtnjBsR9QX5ul5gGslf5ddPodkWW+Vbng3lL6GrrARZ5EJgp/MEfTHkTx2DM
 NZnUkadC+7xsQDUQonAa511mx+t9wxxXIxpzqzSBo2NaPl5VGK3gRQJvINQo7QuEL5OCT
X-Received: by 2002:a17:90b:57e5:b0:38d:e7b7:5125 with SMTP id
 98e67ed59e1d1-38e2a030175mr7445870a91.17.1784231953604; 
 Thu, 16 Jul 2026 12:59:13 -0700 (PDT)
X-Received: by 2002:a17:90b:57e5:b0:38d:e7b7:5125 with SMTP id
 98e67ed59e1d1-38e2a030175mr7445843a91.17.1784231953144; 
 Thu, 16 Jul 2026 12:59:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e4fcd31sm15543656eec.4.2026.07.16.12.59.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 12:59:12 -0700 (PDT)
Message-ID: <11960014-7021-49f5-b5ba-26a8107717ac@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 12:59:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Docker fixes for 2026-07-16
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716195807.3219466-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3QbCXRtvd1LC0LF_tFmjg_bisccQE2w-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfX4hDgblDbc9EY
 q4+N9U/NmZySrJcWhBD12M08F7lniRcWTWiHYZGxBPrA3fBtE9jAv+5xne0CM/lP8efn+UpkQZ/
 MKAFU+dAF4qp4E6OzuhJCcuN+BAzLxWIWhxaGqf07sMeA+lVDcYV4WiCxU7FYOUDxbRsAT5bTeM
 YMr8N+Db9S62sLc8jVCOZ6GISKA9eGTr0+ba3Eh5T0NSXsET/bqaSI27+BLpEOY2s3jLHvMlJcG
 jSv3E6D7GSjpCkBFp0shME+ebtckrRedgq+y0ESc0RHWmchIoX5XBrkrv4N5UZPFRlfDVVi05Ge
 38iyxYqOwbliGVzfPD6rhdyho5E/VIRI29mSOcli3A9W55ZJdxxRETiyJnB7T8EVYu1gPe2B1Ej
 JbS695FrGuAkpc5X8f+HuzQtkamAlAE+OYVtmndL1n9XB/QKCcOT2Gfp7k/awvyg+0z45bmgA+K
 J+kIrFgQHPKriAoaouw==
X-Proofpoint-GUID: 3QbCXRtvd1LC0LF_tFmjg_bisccQE2w-
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a593812 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=__0t8_hIU7gXlkaPYQ0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNCBTYWx0ZWRfXwmOnMkgkoO49
 qn2r4QPwwhFeklGalfG7VFcAXGe5gWfuJbV81UUhb3qvI8+Oeb8HGZtJnsum4vDpUBPKZ12asOo
 lWk42DMe5XucpWIG6n1dQxwbPHhbo5Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/16/2026 12:58 PM, Pierrick Bouvier wrote:
> The following changes since commit eca2c16212ef9dcb0871de39bb9d1c2efebe76be:
> 
>   Update version for v11.1.0-rc0 release (2026-07-14 20:36:23 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docker-20260716
> 
> for you to fetch changes up to c4ce04cfb7460d46c0262d437a7f35bb5c5fc449:
> 
>   tests/docker: ensure container command is probed at most once (2026-07-16 10:49:11 -0700)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v3] tests/docker: ensure container command is probed at most (=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260716102515.1503404-1-berrange@redhat.com
> 
> ----------------------------------------------------------------
> Daniel P. Berrangé (1):
>       tests/docker: ensure container command is probed at most once
> 
>  configure                     | 25 ++++++++--------
>  tests/docker/Makefile.include | 13 ++++-----
>  tests/docker/docker.py        | 67 ++++++++++++++-----------------------------
>  3 files changed, 40 insertions(+), 65 deletions(-)

This is a fix PR (so eligible for current release), since it solves slow
tcg-tests compilation time regression introduced by:
https://gitlab.com/qemu-project/qemu/-/commit/c5ecd377a016997f093801685a73303980be3ec4

Regards,
Pierrick

