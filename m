Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6516EC9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB8Mr-0007Ly-SQ; Mon, 28 Sep 2026 06:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8Mp-0007Le-W4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:13:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB8Mo-0001dr-2A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 06:13:51 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MHT6546981
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rMIlvKW8zrKy9JNYMLAt26eaeLfxiWGMYVGZLdJE3kY=; b=mZ0xZ1y8KvPKxSXL
 PLxvFoV+wdp/Nhft6u6hg+3SK6dR0eVrmdeVJc8T/oJ4GzX5HDmkBFO2IJ5Z8OTi
 d5e0p9kwuFBy/6UdeknjULug1jGnmpDO6GnIZGt99hdfgOAvY3J/eoFWAgHCzrzr
 w6hoPHXJZfV+BTy6gOlJo06DbYG8qLUUMrPBXD1xbCl8KJYE9YuTF6qWR22vG4VH
 5HTX2CNQ4ABdljnGMHVHh4SnYjxgEAfNqmiM9K2do+1QUWBa3UhoS+IRUeTVH4ri
 190qY/3c2x/5nmn/I8hxmMftOLVHIfBsZKPzZuHzaOkEEZKITGNGRvqzfhzK6gwS
 gapdhQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4a039-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 10:13:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a183a0e93so632168685a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790590427; x=1791195227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rMIlvKW8zrKy9JNYMLAt26eaeLfxiWGMYVGZLdJE3kY=;
 b=axnD6dml8WB4KbI3m4VA5eRQNNckJN13LrpxmJ1XhTVQBZ+b9IGd9zJJ6jPy3wsNT0
 xw1SD88l29FijcrT5cmgY/FkazASFB1nRZFS1ArjSLDmC4wP4GOpBDQ2Dd1JdmC+N85B
 aaLmWf/WayKtEY334vxpATUgFTDsEkVLrewJOZk+GB6+N0mAWomp/zEPDaEswmDcW7xG
 +KGydWY1WAueUdAZmUr5PtT/ZOT/nGn1FiEZpwjcqeaLyyJbACMemt01NZm/nPnvtTPU
 v/XO8nTC+guO/6+xNxCo4QjRxQvXcMCh5apTUY6s1GZ+3l546dNaOWM117Kq7RA7ykKn
 +JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790590427; x=1791195227;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rMIlvKW8zrKy9JNYMLAt26eaeLfxiWGMYVGZLdJE3kY=;
 b=rNqKW0rAdlgr9gbmOpnLqL6xVHnVqsUWDD5yaxSaLAbccSI+TxZuY76wL62LV1qkoy
 kJ+BPz+poo/OHLCaCqb/hIN8Dxmy0eOkkvzqeZInjpv/74yqgUBxRVDbFpKxYS1JYUSL
 nYwjjYF/gCWJbZj7BgJ6pTWNuuRc5wkeQ4e4LgYM/qUM5AU+ynu2pcUEIKWj+5SiXdTz
 g6J7VKUGJozTiBWQ/WGhsuL6YrmhE5QyTuuP+m/0bGeij+z3N4bWc7yTA7rU/MiJplP7
 3PqEC1+Urp2eqy9ksb9Yky4Q82CC/dSEGiOf9nJ5vwJFs120WhmHckQZ7Fy2SmgB0o1a
 DQhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwANkEm71irkeEE34BX0mr5Fq2/Cwyn9+kKV9xrZ6yxVF/jgV4AYVgwORzncoW7ERTCJzBc9RMSpzMU@nongnu.org
X-Gm-Message-State: AFuF++nhLpQNEX0GCe1aDv1vFXd/yT4PCFPs8QX7gNCWrtHJPrlNlu9w
 gQa9kj85CRLA+cERpxOyR1bbuDWdpazTQR++B/wG+eI0yqlx1eqWJhPyI64Tsh7CbcV4aX+xvV0
 YUecZH9OEyq19l73U6ATjN8O3lmoqNHzIpB2UOi8P4QIzxJqiGXGfTIjE7w==
X-Gm-Gg: AYBFou2leHENfQglW7HT8MeLs0f985yi2hWie0Q0jXK92cDIT3TxpoYrB+JpV89UwPP
 9GgpeRv3iiIvMnf1rByz7Xv0xvDyDQpl4n+nvlAiHXl4RoXTE9Pt12zyGl0rOd8kgiVQ3tdO+Uu
 D0gBvNGdaH/6cm2Kpqgk6v6SH4JMDDbOdZ94Vm6dVGGQknLxD+J4MfGDm4CYV8Udh9L3n0kxYTe
 krZUEl5K3AEm6RFSDwq+BEOHnPmAxPaCwc3r3kLw6nOXmxiOhtXQBP8cHw8D8PzrHaaoCj/CIL+
 ck+t9lvgXWsxHIylDNuvsREABMPUwfNZG3JzfVYZd/Y87ChWWjFGwv4+iVIS5aUkAK3Jacxh3Gv
 /hrpWZ+BFQRwMh5S6f7sH4cpW6YqYU3tn2w==
X-Received: by 2002:a05:620a:2720:b0:939:f61c:c335 with SMTP id
 af79cd13be357-93c43be51a1mr1973220885a.26.1790590426990; 
 Mon, 28 Sep 2026 03:13:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2720:b0:939:f61c:c335 with SMTP id
 af79cd13be357-93c43be51a1mr1973217485a.26.1790590426518; 
 Mon, 28 Sep 2026 03:13:46 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm29430669f8f.20.2026.09.28.03.13.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 03:13:45 -0700 (PDT)
Message-ID: <9a572670-5539-44b5-b58c-25eb76c182e1@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 12:13:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] target/i386/tcg: Add DisasContext.pc_save_valid
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: paul@galbraiths.ca, pbonzini@redhat.com, qemu-stable@nongnu.org
References: <20260926235620.851099-1-richard.henderson@linaro.org>
 <20260926235620.851099-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260926235620.851099-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UgN0Q1h7SvsUv3fN0umW83OWcaHh9doI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfXzjyBiKsxRncV
 wEEuIIRS0y504b04iovZyvWYM/9iWxpKQXrdRXN8s/4u9Nmi5GrfZivvvJH7uqFGWNkUiD58kw8
 u1fLopEwfMLItbxO5Zqrgj1a7B7UXJuOwY709PULzOCCxNeI832/MkeG/6HMhymq25k0JRtdSuT
 pYP7oYwZwFRNanbu88tuOGq8wzs4e/BJcfRGF2tMAtEAv912Gsv8Ffbpie9sJCwQFYOw+55kqOf
 o6p3ufbj3y9xlcxyYy+4KCRlcp9u/5yFWRomDPjUEIvM8zJuZv7RDiqHX+qQrZK4la5Zck7WMIW
 qzQpoETKjxd4eAM+niWziLpMqSFlgUB067OrZZ269No724qdevNRLt1bxy++rw6EGt6CivcLXcP
 iZ/yiY+aXLbF1ZHjrkxAGtHDQXy1dP86D6tNFp2TKKfN8JPzCx9keKkQZmG9KXXygfDtGcD8o6M
 bPtPmVu4eONqiNI3wPg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MCBTYWx0ZWRfX827BwJzdEqgM
 cr5zq7NE4DmTzlvFa0M5v7gjxaBpGSG2ND2Idw1A235gSmr1BU4tsMqbdRtdfsDqPTgyNxqm8ND
 XJmxgfL93KkZ1fwmo5Mv+POxWo1bo4M=
X-Proofpoint-ORIG-GUID: UgN0Q1h7SvsUv3fN0umW83OWcaHh9doI
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba3ddb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280040
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

On 27/9/26 01:56, Richard Henderson wrote:
> Use a separate bool rather than overloading -1,
> which is a perfectly valid value for pc.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e3a79e0e878 ("target/i386: Enable TARGET_TB_PCREL")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/tcg/translate.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

