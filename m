Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6866CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDzI-0005iN-7c; Wed, 29 Apr 2026 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDzG-0005gQ-CC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:06:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDzE-0001G4-87
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:06:34 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKc3Cb2873449
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SInmdr4uVHE6BflwfKk5CFLmEksr90ngjV8Ehtu10RI=; b=HkU1yWgOdkAYH3KU
 eBXfnobkXED5HFQm10mFu8ePE+O9rtWpTi8D7IixRNo1G0OjxDVQk9XuH1/Zr+87
 QIZlEzBxwvHRxOv3V1cE/ZuJciItamg5pHUbQpCxiceoVeM5jJSE/iLcuExnc7K3
 3IWKlRgamh/WYsN1u6ddoEKM2gdwyTl3DmPW8x8Io/gAukGWpfYjejiMO/qZkoTw
 JK53QSyGB7/rg1hCjESdQRaJEUVT4Ek9Gcw5yFR7nBkV+AX8cgOywd1q2BEZV7px
 Kc5tcJpcEFQQw01itQr2vR4qZOKfvXNPozTYdoHObivPiFChXMrNIYwQl2XcuXgD
 D5eT/w==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9kx2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:06:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12c87ba0890so1538105c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503989; x=1778108789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SInmdr4uVHE6BflwfKk5CFLmEksr90ngjV8Ehtu10RI=;
 b=VYwF+Zb0e9uNfZK3+PUZ9ZIH/7gqAsHCEF517A+Z/sydMzzoAHB2H1aif3QkjDJYx/
 YfIBpdLKrLN9BlgdTv0xXLZNdokgP4uoaosqGUp6jNy6OqSPId1jeH3ULJukpMFFeMTE
 2CwFnbPhuzrO8DVyeF5pCz9EXRJzBBRf8JdgKCMJttHSyXxOU7h66jH1BrurM+6Hh5Iq
 OvslJdcJ8Fwy4xjafbLIwY+Q6hhwkSPfbJVy2bbFK9ctBVU1U31lSlE66Y9izHRn942J
 Du4edRKhSKK5fFQvRH0B/holwYmZbvFu9PQQXcTeZk54SX2oZLPK4DkdSl9/oQxF4KuZ
 fceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503989; x=1778108789;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SInmdr4uVHE6BflwfKk5CFLmEksr90ngjV8Ehtu10RI=;
 b=lW9FTLZHb6IGzsH7ygduJpiLx2CZRQBPpmX/fP9c8/9L/6Xi7i6toEA7qu/R+Jgsc7
 KTm1HQ8cnYR1v0y2+yZQyLyQWWucwljuslvYZRbsIIrHLHeKbEvIQMA9rXXjCFTTx+b2
 Ub+zosrVDA0bfRw0XpF7Rzrg06PiZkIK+o8DBf0c4OcfPqlkOmrS/OOXlg8d9VTIP2pI
 7MYQM/OKFlQB9z0HQpuNsYJhQ6ed/g95/VQUdxCXweZrnsx0Leoi8x0es9wEGgrCnpCl
 +TNInM7c2riUOEQt+VBz6pNv0EuY89UMox57FkG+lT88HRw7s5YG1Z70C6VZVcWhIzYo
 7Xxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5q8YIW8BcU9EixAycPYxoWj1tODQY3Jrboc7ctrAEtKvUe0FQprr66Ydps4VvXUoGErE+LR7B/TqV@nongnu.org
X-Gm-Message-State: AOJu0YzX22VZqqWJTfZeH0A2a66r0lA9nhnbCYZ9BCzJe1GXk1gOsbT4
 FxlgbGu+2JTLZtdluXDkqLOHYcHQbzV7PJ71uZOK0bnk6xd46/GBObckbm8zismGdgmisC95lgo
 gG0q4k4OMudEN7L3bRjAfgcpY4Y+dScwcMGmMJIFexeirAqiUFkdWCF3rfg==
X-Gm-Gg: AeBDievqGhRkUb3GgLBXLJiA9OsWHPROQAQl+j4/JrZgxQsosCQAiM8pDrNuzvzauNE
 bp+CELY4MbWbUYLm802mBBoe1t0wj/j4J2aj3+jTGK+bi0YLJ8wmoXXBz7rhmwHDphy2v8qL8/u
 SCFC/5dzZ5om+hyF+ajNVzhFUwDBIxY4C93WblZJRr1MYz9zNhlj65x6GzW/92ZpZTgeFbWEDiQ
 q/aOW85zu8c3PjeN9ugKAyaIhKA8D+40VpG2tSZrWo+RxbOcoR1Jn9Edw0ctM+EETLqM7tJXHCO
 oJ2TzapePV5HIE4MnSlhHx/Ljhg7RctwXE6weQcCYQ2LY4dK4Sv7HJHkzcyuSYgBo6r2SBEYrUg
 DuI3vwSbkBFDrSRi4JEIl/hhLOZEu+Y5lC8Y/ratn+LJuXdPQsKzr0nksDX7Tn/PkiyyhCgS9s5
 bnR84QpN8oVdEK8sqWGBLY2M7d
X-Received: by 2002:a05:7022:e17:b0:12d:de3e:52c2 with SMTP id
 a92af1059eb24-12dead2cc52mr267669c88.38.1777503989399; 
 Wed, 29 Apr 2026 16:06:29 -0700 (PDT)
X-Received: by 2002:a05:7022:e17:b0:12d:de3e:52c2 with SMTP id
 a92af1059eb24-12dead2cc52mr267653c88.38.1777503988876; 
 Wed, 29 Apr 2026 16:06:28 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de3261533sm4886758c88.9.2026.04.29.16.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:06:28 -0700 (PDT)
Message-ID: <3d8add09-3fbe-4d54-b00e-eae292d67f8f@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:06:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] bsd-user: Add init_bsd_ioctl function
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-17-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-17-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4A7tWcKcCAaTKOq5dIcVopKqcZW9vA-7
X-Proofpoint-ORIG-GUID: 4A7tWcKcCAaTKOq5dIcVopKqcZW9vA-7
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f28ef6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=P-Frm1ySNAdyxxxc4ecA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMiBTYWx0ZWRfX079hcg+tmArU
 8jDtpVPI9htuu+uAD4OV0bjtNx7h376pfAGoyIaZ4kNsjKOQd1oFnOSZzAuswFr4jvV4RnejShY
 8A1NJZcClCCefRsVZeGHozuDw8U0PnFhZze4MkIvrccNWvL0kImZMMp3Z8xQFMrvR8RaGDNi7rU
 yAzBEOhQidwix2so6UTduCyWf3zukPdQnI0Ky+UN7+FtS2zAsX8AkQrS1hKreEHpmQ+1kK7QbVp
 aDfrW4o8c9SsfzGmwzoCTB06r1wuXh6vo+Z5UICsnbVZ+yEv4Zzrl4Db+Y+Xm7nQ08UZ8256lJJ
 7Lxbop7ogzdY2DWUT27eTaTJ+z3vM7y4SVq76nhsqql9cQkq9EieedQ8xi5tFAo3a35A8VYrWrv
 sFpteB08l3l8fXIY0SDY5P4sAw3a2kA4uJv/CA1bqknqLXHPAppifcbYQ2YGUSaoB8JkAp74RTn
 gTSu48hRPhe1/ppY1iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290232
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> Add initialization function that registers thunk structures and
> patches ioctl table entries with correct size parameters for
> target architecture.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/bsd-ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

