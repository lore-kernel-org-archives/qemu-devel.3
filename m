Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DF5C88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E8E-0004p5-5h; Mon, 14 Sep 2026 17:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E7y-0004Er-Ma
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:22:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E7x-0003h5-4h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:22:14 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYaut1485428
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RjgdP7nQ5WSi3KCHgeZWsjnBTiLJ//FlK+0cgZgR9wE=; b=m+7Ux64H21tIZl1q
 IvSQO8n4iHVeatRJA+peZOG4Hs1Qn6PzCCC0Xe05GyUmL1iDff0ixB7bPuRhynLZ
 WhN3oa54todJ8jztaZ6Dkq3o+/ijMW6pBAAIYblSk3v6dtPYqD4gIA63vbex5ajt
 H0YoYYU0BpwZc1XJ1F4p/Q5xVl47iTYWztBz+bUcu5MZsSbfGnOJcsAzqvlzOwwP
 PuvN4YGTdq9nwAyBH8v6Sm1i19e+VDv8AiAxDEDeN1HKeVye8biy4FnZI2W5ZZlw
 gS2HZ5iH1hljPArS4G6N6msifsmTRiyNJGdZPFEcxJjGildwIwE1BH0DAJuOBiBS
 2dua+g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpg2ktchp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:22:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39b6416441eso7199515a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789420931; x=1790025731; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RjgdP7nQ5WSi3KCHgeZWsjnBTiLJ//FlK+0cgZgR9wE=;
 b=CIysw8SIC/MfH/VriY502yK+8v/6eKmBcGZBHE1D3fWm7wMFPO/UEQeOwBTsNiK8uI
 FbUSssAU/AaPX+qZq9wp9Y3i5ZwxBF00oRdh3MFxf3g+/Zm/MVUa7AGIp4GopiLEZC+o
 f5B8M5uQGOUOHDgFaZJwELC4Pwo5j8z7EmOXb3g31T+9mQcHxQ2t72GNhWxeTCscPnJo
 TzTnkIStgKcRzdop46LSL26Pg4yZZd/XKLg4LplwG7UA3r41e1e3wedpH9wNPyId8nRY
 M29c9tb5Q2odL5fZWXijCVkoWo+WovYS5gYTtXWWgFsdT0sFhKakiZauLdIJ9DL+75le
 kLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420931; x=1790025731;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RjgdP7nQ5WSi3KCHgeZWsjnBTiLJ//FlK+0cgZgR9wE=;
 b=Ow1Dnyc0+Xag+1e/7shVe4TgOrpkEGlSMHLTngMHdFVN+Z1Oc3E2NWE6C96LAllrlO
 I5ptHiIhAiDn2yeUC1KsanSCQris7k0xwOKXz9jYY8l2KKTzTtoQfnvQwsgT7srgbyc4
 w0q20Eaa3ZIRH/PBBz6XWCqak14mSAoZOX4XvdYGVUeO1v6y8pDLBVt4ZN4b+ZEs7Nm0
 Bant0OPJD4X7Zw/JtVU/Y1CBqbpdB/2m/lEhS/3r3eRNnRrT9Hbmla21ckSB8szJy51I
 RoG3LZ4g/cDmnkzJHcegv8Hkwi3bGRrbh/nYa56uhFJprdjuwE70UTZDa2GTINlI7njO
 A96w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlP8NU3555NV1+ZKI0TDBT2QAxprF5OVzdNtiJ414+j/VRQp4qS/mCsP2hL4a/Uy4Sc9vI+qBfI8w7@nongnu.org
X-Gm-Message-State: AFuF++l13cuKETvbk/AageCMy1PC4vpRTlBIXE63fb1F4NDslWSRFf39
 xOc80istfH7+Jbjqw3m9o88PJWDB3fjEsV4HL52bt4opG6Z56Y0weLDqIcIb73UlmkdzCbGFcet
 xrO94BWLG1q50/TbTBpvxLUI2RpK+8c5olPuPvHXtAniuKSc2zG3p65ptABVbZPQ8EQ==
X-Gm-Gg: AYBFou31uessU4G66JYpYOmUE2jsXGHe2kFeWyRVBh+fM6PG26qhtBYZL0QmMGVGhwc
 Nheno7/CX3Gk8TKb6iJp5elGzquHOE2EF3oci0/dl7hVVl4GXFk74KvG4Q6uBnrp1mpQvQEK4Ez
 FUYpo94LP9vqPHyd+6QNEhv5DMMnIqEIQYo+ykk95Qhq8nNiz83S9yYqWBsWfbKajrrr8qxuc1L
 VItcvg+Zmdy/pmsY20VpPCG52lONepe557iwfpsgC0XMNQbkFXu+3DWUdEmMKP2KRLhBLx9IzEX
 +IrXJJ44YGtYDwNuDrvRWBqWD35ZEcM0eIRRM72irbCXjYXJ+N4S7gwz3takgrIuR8lCzHaY3hA
 MsDlAaEaS0JDPl9CHbTJVPUPfak9Izf4dOdCUTzQy78Md64ZDjhwPPXDVgZp4HLsejIOb
X-Received: by 2002:a17:90a:e188:b0:398:b71e:60c1 with SMTP id
 98e67ed59e1d1-39dec05885emr8381839a91.12.1789420930920; 
 Mon, 14 Sep 2026 14:22:10 -0700 (PDT)
X-Received: by 2002:a17:90a:e188:b0:398:b71e:60c1 with SMTP id
 98e67ed59e1d1-39dec05885emr8381786a91.12.1789420930519; 
 Mon, 14 Sep 2026 14:22:10 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e51449sm24878894eec.5.2026.09.14.14.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:22:10 -0700 (PDT)
Message-ID: <931e6976-bd90-4675-951a-98151a0bc5c7@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:22:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] tests/tcg/hexagon: add sfrecipa edge case tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-12-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-12-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UcagLAvWnOLUgMexJSY03LuHrpQqRGFb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX5F0WRLnGsXmB
 T6kbE+eW57I0YJ3+0Yz47bzbY1Dmqel27wywn9F+lNVFP28sUrVOuqY7LM6s3ImnMPdf/yam+c/
 mO/mMFKprQbx+KDtVDC9RF2JluqhaKVLeZRQbLVS1RbXXAOxT+RiYgN5h67PNIyrv3xHOn3dEql
 JjVdArf8KiwBjb6y4GnZBS3OYVZMoZra79fiIysqjmSHuHYVfy5ByCCMQiKcHpwAYpN3Aat247v
 /S/hhvUr2yi4hPgii8ghNcWC8XRwoqWNmx2guRJ/l/X0x/F/Ljf1r2ANKSxi8j5x9/6u73QaBw5
 Vu5Fz8bcbLN0uD0awvfCNppRbrduMjr5ntpV3NoXhY+Pn64iNcxXGfZ664fSZ+SaLLhIVGjws1m
 yZAvKNrWHds4dAhIWpx7b4vQ9ZcYWjVm0t1JZUGUOrZmHYmKuUVOzEepDHOoCFQvXlJWcyQ6bqi
 XPH7nIrYxwyP+Ripi9Q==
X-Proofpoint-GUID: UcagLAvWnOLUgMexJSY03LuHrpQqRGFb
X-Authority-Analysis: v=2.4 cv=M7TYuCws c=1 sm=1 tr=0 ts=6aa86583 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=hED8FKPijGGzw3a95AwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfXyGhMPo1hJjxk
 fLSHiw9Fhn4QZY/hjcyqNU78a2ykFeZMsQXLW8PVREirTXURQ004lot0hbRoOl0+ENvz6icjJZW
 b+YWIn9nViQCtWs8O4VP1U+PudSCuIQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140305
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Add edge case tests for the sfrecipa instruction
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/fpstuff.c | 81 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

