Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwvb-0001B3-ES; Fri, 15 May 2026 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwvX-0001A8-1i
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:06:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwvV-0003gp-9J
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:06:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FGkqMs1353908
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 18:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u1dC2OU9rmEb5xEVrzLKEn6dVOEFExpzwFuOm7XTLZk=; b=oXhzPZc5cex2xhPG
 Hn3Qb0A4xjBhiOQADCH4y+dEn/r4cgX10Y5lGov9RVrPSQj/KMJn1QT3E/+yGIK+
 VHg31Y06gb3sYP5wdj/p8K5NEnYRg+FPQw/F4oF8DleqxTtLxkXPV2seef/x6SLr
 B+MbmX2NETy6i8oUxhUIpI9E6lHuQnVEirG0s+I0WTPioa8EBtMTfM2zJ9Cs57RV
 f/U6e6tzy90SjIJm6ci0IhzQUuVc6EBYJDv87kh9k+DnILQUE1EPxHlkNupvj5MR
 HlA0OCDIFmawCyy1hC2X1xobB/tZyc+gRNeVOkrY1+Txr/JNfAAF5CUqWvmz4H8P
 zrXrIQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e67ac89yc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 18:06:12 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-134cf343c58so61867c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778868372; x=1779473172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u1dC2OU9rmEb5xEVrzLKEn6dVOEFExpzwFuOm7XTLZk=;
 b=OXpG8Oz3Kj59FNV+t3X9NTxB1NArCz3nI6ZkveimfYakJiCRyB0BTYPm5/DZiqFCai
 4pULxPLfmSC35tEH6CDlRnvMDEM0+HGWX3MP8BhTnuiTXv0iNujroMCloTJXdxRV7WXB
 5xP+ofdN99Tqh7ybauwURXc7aRRisRczbXBmJkgFPUjENwURaSJNvtsilxULDin56AHG
 p9AH/LBT+8Iq+N0Gj5EP3M7FPnl2X9rlJ4igdALQIvFwXinkS+hmiwohg7KDyaOSKjy0
 82XRt6v0TRDFj6Pg/sCY5Hz1Advcbifs2L52Gc+Ol7Jiw0ZmI1/D5UCS76TYaTfZVU3z
 Py5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868372; x=1779473172;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u1dC2OU9rmEb5xEVrzLKEn6dVOEFExpzwFuOm7XTLZk=;
 b=GX6VVoA1j21FBv/z0FHi0QAhe3Oj9gjuv/BL+i+RjTyufgEcSQL+uEXj7Bkj6fYFPr
 glOlp/pS6Rtw8b2rwzGTGCQS9RmsVEeeLEuf5T0KzRq97fpGR3JkNnPo+1l+8UHB511Y
 SuVDL5RddmmJT05fFCTmhVYSts/esUllkRGHJxamQq6DkN++x2aMxrcJam+jvsNbabz7
 yqn19plX/iboLWEnjzCB0zhsCcl7ynvUxIZ5FPZG8/pfIloEEhyMPplBAPsq/XTRtDVH
 OQoCylhBXRm/RkorKty0hpmOjISVDeaQwFmZQm6QldUIodgeV6cl98tiNBzQBWhAOOCa
 5xrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dge5UTbdwyUr0VIHpjWS8ON1aCksrDPZAcTRoGdNBTwPI+2pjNl35zLUCxsBiUeqd2WKBmyp9wYui@nongnu.org
X-Gm-Message-State: AOJu0Yzk6Qo/iLFCXp6n4T0hDLJWCAtjYpazJiPZbpDH3l9M4F0TLRDR
 QGgFZGkWJjYnoyya/gAiujBT2apIgTiOzF0uOGH+g9lRTjYhtw9AuDpX2VVgayRaF48fN5SaBdZ
 AnXAEz/5GPjYFHjucFQYeGi3xGcgZG4I8weNLTytZopYZQ/vVigVaVEVygA==
X-Gm-Gg: Acq92OGmzDpFTvdgxCEYJTZCcneo11EIwohhZdq3yAgwF/4vBHz9OEPFN0p8ozymCYc
 XzJA9NkyN3cjO/ZsyJh+zusjG9l/NdBbrbRgFotaX8KaQJJ4PIM53FtfBxqo9FR5jQM2k1of5hh
 dtBlU3Mq1PAhvprnSTDSb6fG9utIzEg5piRk1tLzyixLJ2twktrn672vXPp3GN/pa6LG5j8Pog6
 +2oCDJUPzhfYCJnYjUBr16z1K1ad36EzbHtuxWzfBr8N2N5Qxn5wIehyNVBrC5YfS+pQiv8Umxf
 7gLYu6m3hIQsiuIIaQq7w66HAMpf+9Hbo+quJhjCWQkGEYnV3vm7cpdseipTAwDsiY+u/RvKe5w
 5Vq1O6VnYWlk8DVIPEpNSpPcAmDmdQutESwABCwDS7C5EonZs/n2KMhBrYhH3t/Y25ZZLYbCZ2f
 UyY8XHwsrfp8BZRw==
X-Received: by 2002:a05:7022:688c:b0:12d:ce60:cb52 with SMTP id
 a92af1059eb24-135045177e8mr2435814c88.18.1778868371571; 
 Fri, 15 May 2026 11:06:11 -0700 (PDT)
X-Received: by 2002:a05:7022:688c:b0:12d:ce60:cb52 with SMTP id
 a92af1059eb24-135045177e8mr2435780c88.18.1778868370928; 
 Fri, 15 May 2026 11:06:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbed531esm10570306c88.8.2026.05.15.11.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 11:06:10 -0700 (PDT)
Message-ID: <8cbd526f-ec6c-4014-acc9-ac12657e0b5d@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:06:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 26/27] target/riscv: Pass address as uint64_t in
 cpu_set_exception_base()
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-27-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515180437.23620-27-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: i08M-g0zfYdbXcGzqWiwNHBg7vJZbSan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE4NCBTYWx0ZWRfXxP8TWcq7YyN6
 pxHParfmmbk5Y1tvoz0o8Xqfs4W1Rwi7OUvjVH8tqzdKW3zHwmtFQpq3CXm5+Zprs8ey9jgchD6
 H6vS/7IUZKT8IECs4gNBBEjZvdDQ9FZe30uCSbIOgeOWR6Fxbf4+y/KTRWo6xIPIvJ8fw9fnaW/
 lccxZ+kClv3mwPiOuldsQ/sfsnga34KnqEr8PmhXOY17Aiat+Jzk7NT4WVplp1C4FHMSLxkFkYg
 ZaGysyNflCsa/ZZMWHO0YjpSep2wyvd1gskEw5MSzHqtexr/pVVZGPA8i3/5G/luw8MKZ3G1ca3
 CGgp32eafjw9nbyXJ2lT6fhIwwQgkvxc655uSEeAmcwIoiyqvlMDZGX0f5s1nCRCGsV161CHm7e
 ABluwjF4yxsWoR0So945wP/nSlKcDgQFGUAzRAdYWUu5J+c5mji2xeDOn+oaqoHxUIjL8/hdxPp
 y9TSljE/qii3KNZf3zw==
X-Authority-Analysis: v=2.4 cv=SuWgLvO0 c=1 sm=1 tr=0 ts=6a076094 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=SN4Way2Et2FXKZ94zD0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: i08M-g0zfYdbXcGzqWiwNHBg7vJZbSan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150184
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

On 5/15/2026 11:04 AM, Anton Johansson via qemu development wrote:
> The corresponding field CPUArchState::resetvec is uint64_t anyway, no
> need to use target_ulong.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.h | 2 +-
>  target/riscv/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

