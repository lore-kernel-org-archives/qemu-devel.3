Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01302FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDt8-0002CY-V1; Wed, 29 Apr 2026 19:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDt6-0002CI-Pe
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:00:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDt5-00086L-Bh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:00:12 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbrZU1133038
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8mf+QQ3j7Y5auiqs13WRrNl2xG9Xdf6zMqr3LUGLstk=; b=NJEEoPdyUzq8/MXn
 DOwLSgvXk+DBr5MkbenDbOlxbKX0lVib+ncuQ+RQ0MKMPO+TILXMCMLPgsm2bl7J
 pSHSEhe2O1ev6J2bBnazF411YfYxRcnloCwk2vUhLofij1Xm2EdXaBAf7kd2K/5M
 PGqyW8vTgnezVOXK8D99KSqNyFPCtdT6xPMp/KAC0/70Afry5hGlvt1tte2y7nlZ
 9BxpyQwyDOPoGCQii0Z4zf+9TVADXnEJ4PQ4rlUEnp0Mn2uKNmyCKYWrWN7fyH9i
 q/0Vo/xs489BRRPsaL3a+qLst4jVfJ2L0N6Mon2KImlSNUoROHuDE4PK9a0FxvKH
 oaXKzg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duch1ktff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 23:00:09 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ddd8ef5343so370038eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777503609; x=1778108409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mf+QQ3j7Y5auiqs13WRrNl2xG9Xdf6zMqr3LUGLstk=;
 b=WA8tCO/3VKygGSo3jDaE1iedFYbM8TXTlb51uPHzmqWw0D1/dzb9MVXS4NJZFmUUuZ
 XX9Y4NDb3ndymscVQSsrBtSl9vIqirqWnnVJtgEoDyRb8xLQb3bnBnHcRySP9pqW1nqU
 QaANJWzcXicwIVN30PH3iLwqQ217XCTsqo0SXwepdvyDFuKBtEhF7zpMpPaF3jiL13OG
 WMq05ueMhhWn+2koRl8Wiz9anvWpNM63z19NDVLETApWy303s3sE05Nlt0GmHDuO3Ktx
 5hXaYxuj5LVgt5aGjBxZGmXnjv0KVlGp2I2rteOwGHr3NBu6IvKMpvrcqCtLC7pMv52k
 u69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777503609; x=1778108409;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mf+QQ3j7Y5auiqs13WRrNl2xG9Xdf6zMqr3LUGLstk=;
 b=WSU792S4MRVoRw14iMA7hfXPonnY4Q3xtRGQ6SmFvRzfENeyI88Ae5jXvtV5t0iFSn
 A6Rv4Oav+LKF1B0NCbFfzSAdknmdTGOrJDCYDzz+BpwiofBIz1lkqsJCWvaOofBhHJOK
 cC/1basrdANAk/VngIT6hMmiNmIkfnKHs02xj8B/dTXXZRCTq/dbV2EY8sC3YKhPzAWr
 Fcf+ul8ivYVNSoRKKFTNQUxEY2BS1coK1/d7w2tVZrXRcqmcR/OlJXDQmASBSf/m5i41
 gWJq9Q9FMjlNFqtWzR2UxqGcRitHc7pZrXBrzlViflD5VoXHeMuTsTiEfKjvNXUq0PX4
 4adw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9PDzyWOExn6o/NsQ6O0FayVGDxxRy3qVwaMvgpjQq7exXrbK9cQ22qB1g7wAr1TwOavsWPak/sSVph@nongnu.org
X-Gm-Message-State: AOJu0YxIDwGy00vVqrxPg4JWz6TaRWE/GVQSRjzEwPt+MqZY4Zbm3AM8
 biFe5AEzgPb+Jl7Azrnw4E1cJNbzIF2Lp4xOLFKYjWRW63rgYGLSLdjYwsOFPo+GY3GpwbI/cPC
 ON5OsoBXdDDIXFYMvjSyS0aqmjMjURTZhYEMcfB2B0muKPRfF19jrULlLwHbGfQ9VCJUW
X-Gm-Gg: AeBDievHy7iti4j8ZEb+uXGEGkixdo7xJPXL/CHj7+FEDICSXwdpySaRUL/zRqvWq39
 1jXH6UrlPbdfyxh+DGnh/5Ot+Z5g2X7j9xCaWciMwLOhft7uQ0pQh1ig8aTfasoS/UdsXGD8xwa
 EkhGo2JpnDVbc7eZhHH3lD7GqhcFZef+z+N1FMu3yYxMqymDXMBQtDAPWPvrDcw9WH7mRsVlqsn
 TuBvwsjVrqwtwX2LZrM+VEk7WP3l7b96vhp1jkd7LyRoPZc/MjNgEbUfoyQ6zaw1R/xwNKX0ois
 PSMhfzs9uLdwovT8qOAsCOdXEuLKMgQ4/XR+6kqkTDxAcKy1ZmssdlKw8ot0XKDFrihhB6HYy4V
 zfnBY0ZXCx6kK0piPBcOG2QNrF7OXk791nhYlYNn0X3gZqHZANIdBWnD9ISut5AQn8lJi+4ep/D
 L7Lzl9rDwoey5SXU090+pCS9fN
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-2ed3d5c6b8fmr140073eec.8.1777503608573; 
 Wed, 29 Apr 2026 16:00:08 -0700 (PDT)
X-Received: by 2002:a05:7300:e402:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-2ed3d5c6b8fmr140047eec.8.1777503607848; 
 Wed, 29 Apr 2026 16:00:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e2d1sm4431033eec.8.2026.04.29.16.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 16:00:07 -0700 (PDT)
Message-ID: <a90f8468-9c05-44eb-a3e9-1ee4807ae69d@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 16:00:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/17] bsd-user: Add target_sockaddr and safe_ioctl to
 syscall_defs.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Stacey D. Son" <sson@freebsd.org>
References: <20260429-ioctl-v2-0-288639bc2427@bsdimp.com>
 <20260429-ioctl-v2-10-288639bc2427@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-ioctl-v2-10-288639bc2427@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=arGCzyZV c=1 sm=1 tr=0 ts=69f28d79 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6I5d2MoRAAAA:8 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=SMWQj5xEYIAdububahoA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIzMSBTYWx0ZWRfXx/E8UZtLfwa0
 0Lykz3GowDVhrKdo6xKnlT9u3+hlcdXnUVw95Il0tSEP0MRC/JYje+T/3HMlOVyGUkwp/kDk6EM
 r5HXuk3AxTD9G6tjvxI1HVvvmjVkbhapAJ6UbMJcKuPvUzijVBOzsakgKPilVPAEJrce700uYw2
 5OG7Mcu2c+ZB0NBm9uGylFmi/Nux7XcnulEd4Z7CPoxV0vN8AdyDNxLd/WfShMFZ8VUqifV98af
 uEUsQmwNMJ5oNFi8t+T6jV79XZEO0lXEQf5aq4JCjUaD47ill85ClNkkMXbTGU3UmLmUS04jXbd
 maE73zqEL5hXCgBYX92N3B/oAMwQrpFv6xv21b+3e8LEzaUO2frhcTM96CkeMM6LVn8L1wm1cC0
 Qr3GS0O+d1PGOjSQr+Ey0VOUrQk3XTpLg1L+v+Pf1irnYXjIitMu0D5lAYiweUozdfgQHqv+7Rp
 FLxqF3V5vErswn8dBSw==
X-Proofpoint-GUID: Wa7QwP5WqRNwHr5zUOTFjdz6L1WgSbpM
X-Proofpoint-ORIG-GUID: Wa7QwP5WqRNwHr5zUOTFjdz6L1WgSbpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290231
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

On 4/29/2026 7:45 AM, Warner Losh wrote:
> From: "Stacey D. Son" <sson@freebsd.org>
> 
> Add struct target_sockaddr definition for socket address handling
> and safe_ioctl macro for safe ioctl system calls. These are required
> dependencies for the ioctl emulation subsystem.
> 
> Signed-off-by: Stacey D. Son <sson@freebsd.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/syscall_defs.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

