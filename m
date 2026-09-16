Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F68C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6t06-0005kg-IK; Wed, 16 Sep 2026 13:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6szU-0005Td-3f
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:00:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6szS-00048N-De
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:00:11 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GFeOFd3709163
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Kt1DXg0ZR71yxnt0jF0Xwp/+qXTS4KAw3xZ6JK/VBs=; b=WOxFtBk9uMA0UTNV
 VKoDbD0vI5YfC9DadNfmWpZDiL66ekSkqFqYtgYOlJiIolKajMPSUnOfdWM8W+k+
 Rw6yO1n+G7pFS2gMqvFmUTFzVNyABFuAeLCNc6g2friKybWLsp8Wqgk7Jjmrik9Q
 UPFpfAqQn9dxEJuxT6JUMBmwehmd/JuHE9G/oTgNXUXnle6jd18IPONrn4YhP7Vn
 3JlVMOKBuXWw3YCCZLODPrKza3L6x/D6pXKO3Q66OJJ33K5Br8H9jXYyPXOASRD9
 k9NxZsm8p0G38gDUBfqeK5S7NvOeRo9Q20YROspzsIgnAzL7xBG2aLXt9tgWBGGM
 E5l4dg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqfvfm1jg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:00:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso8011939a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789578008; x=1790182808; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Kt1DXg0ZR71yxnt0jF0Xwp/+qXTS4KAw3xZ6JK/VBs=;
 b=hjebInrN36vfODZhhqPVYCMCAz+RLTdh10DviBZ8LSiBNxDeyTG99qcNTICZHg35iK
 71V1ShrQEIqm5BF/DeBTymfxv1IyT9U2aTBXcy0Yzo8Csh+N7j1d2FZK8s5aBfJGEXlH
 5IYyewJxxrD7yj4yOdVMHQIfJ/9n6L4N+kdyitumbPI3yI8g8K0PpHDbXdS2xnHloluO
 ty6m9ONAigdC94JvcVUiSJmw6jnv20oEMlC+CBxPBFRk42N20vdNXqRggWcTJMYvBV+S
 a6UKyNv1Tgy7xfk9kLCJ8yaVcgcbOo07VLCM5leBkByarDBNf7b/OwuVnx1g5TJSQnFL
 J6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578008; x=1790182808;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Kt1DXg0ZR71yxnt0jF0Xwp/+qXTS4KAw3xZ6JK/VBs=;
 b=SdwjBDINcKgjjOJSb8vjxHnL5AEriOic0L/fum4WpdQ+QpXtUA4JZ0PbybmwJC3DAn
 64RIvAmmDWwnu6jE9oWtQEDdro4d55ra6jmIjfQve3eWw5QN/YK+wOgbrqENVf35ccnN
 EFIp96oYxN78Ubs/9/X2/8A+0Fn1LouC1BBwrwP/WXumI0QaM+g+dw7/cg9wotdUrrcI
 5+O7GtY/FWn6R+rlRpiD7T2zHOBmxhAt3CwhmjmvoSw+4/im/BJ8R4ucLv/waY8sUagW
 VXPmVs7AXoFT9c1+C8TPQ5IiJLGMv3KRSrh89LjemJR9NA3ddyt72kSrnWBhpWGraPNB
 f8JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgVpJCYeFVjq3fxXJMaUPSKf3nuBrJw6GFLL7pWU/Ehj07ho8usQVihmTka6rJo5IJDc8P44XVtcHY@nongnu.org
X-Gm-Message-State: AFuF++kV9OKXVXLxXrNmjF4SAFLXcI5VR5O6N5ADoYPl5xHUeBPlJqvH
 B++uzmgGUrQCQHz55eJZdegivlcaKutPTDuOnJFAds1VOxV8t/Fi0PtDOSu1oANje+V6NUKbeJg
 mG/+nQncGT56nUtaOY1nNjBmqJ9KgYWjsFVzXmC2+vAR+Ye9cAGHKRvjVhA==
X-Gm-Gg: AYBFou3+LM4nIXFoHFz53VBq0IsxxQjF3zyz49/MP2/FWIiF++Rz1rIxC9lVVa+woB4
 6kwlhHokhY9AutqE+ngNMss4wZ9/UHJ3m2aa1ELcp0l1pcCAfh/1Rq/Wv/M9EMxKbKIXvGXO5/P
 /9bEyfprd5Bzc6Cbxh7Wh5kN5tvEVb6HNufb+nUn7g+I4gSv8l5KnJMj5Ep9AbEh5ZroI8M2oEJ
 twcxZK1feL61z4eRsxy4gDRoCe9nSLicIfIqR1wnAxeWIBq1HiX9npXsv5b43on8VBe3bn369Mu
 hg4st8AxMVvjebVlgH1rrbT555DJXL9dH54BkZYqBEoOLWG+B0F4vGFPPw0NDAtOoPY2vb9C4BK
 9QkKrE4ZAzmeUCO19sUngMWIowfTsPCjBshaxgRL+eUnQHEuLaVQcDlq1reyA4v4qU6il
X-Received: by 2002:a17:90a:d2ce:b0:39e:359e:ab44 with SMTP id
 98e67ed59e1d1-39e359eafb3mr1247595a91.22.1789578007991; 
 Wed, 16 Sep 2026 10:00:07 -0700 (PDT)
X-Received: by 2002:a17:90a:d2ce:b0:39e:359e:ab44 with SMTP id
 98e67ed59e1d1-39e359eafb3mr1247361a91.22.1789578007363; 
 Wed, 16 Sep 2026 10:00:07 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a1a5sm9658704eec.5.2026.09.16.10.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 10:00:06 -0700 (PDT)
Message-ID: <81558df8-d12b-4cee-97ed-881db86484e3@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 10:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/12] target/riscv: Stub out kvm functions
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
 <20260916-hw-riscv-cpu-int-v4-5-babc367b60f5@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-5-babc367b60f5@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JYkpPkKV c=1 sm=1 tr=0 ts=6aaacb19 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kpU9yTeD4eOIFxFAU9AA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX96873sRo74+u
 1LG56SD5XnY/HiK4VbIjFZwyDSYnD1617YzLOgwK+VhQk4KJ5HKXqctq7G0BidmMn34p3GwYnM1
 Tr2YDypKc3r9ego09pCuNFc5o83wc8t4nGTNJMDltfzO+F2Akb1MWTuAYjdbhjgZNbSJXkP34lx
 tcjfHrvVMBY4tcvSBTmXXYWETlXmTYhbVaffiq7P0TNrSQUnQTxvYY7fUCQCSM34bn9Rh3Krl4N
 Dtp2eG4CEoBzyWU5gkCFcGxHxQ570GEjN+T8x/D5XHYyWuGiu1pePxFLQGY17FZxoNpXi3EKZ3U
 8ZCQhNxYPj/Zmu2xDO4yqBKsAqLwntkMp8TQVOZTK/gDnFEQ7HYW0PmhNK/uE1SkFxfE/qbWnC0
 HER25UwKIgO4INMgZIG/5Tugr6KgUbNxlFGk8wh5NCrAkQFtjS4TK774YD1gFGegcISfNWBQpnI
 IVBZMcfdpJlBkIyRmXQ==
X-Proofpoint-GUID: HkYbFfrSZbVhMADN6V6SHSUZtoLUdfu0
X-Proofpoint-ORIG-GUID: HkYbFfrSZbVhMADN6V6SHSUZtoLUdfu0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMyBTYWx0ZWRfX/sTot7Vog8U+
 LerIjONxw7R11BoY0jQVlXc7qCmjPQJym9zn45gW8ZoqPz76YLmD80UBpzVgK512L4Ipu6V9gqL
 /dCESBFus107B7ycMyL1oIER3JtZ+QY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160233
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

On 9/16/2026 2:19 AM, Anton Johansson wrote:
> Functions used externally by hw/riscv are stubbed out for non-kvm
> configurations, allowing a single compilation of hw/riscv.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
>  target/riscv/kvm/meson.build |  1 +
>  target/riscv/meson.build     |  3 +++
>  3 files changed, 27 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

