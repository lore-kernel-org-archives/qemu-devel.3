Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B5C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 01:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjoRz-0008Lg-Ea; Tue, 14 Jul 2026 21:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRx-0008GP-5n
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:30:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjoRv-0002jL-K7
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 21:30:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F0Ivqj2225942
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cEnBrQNGubCmFtquwfieGVpco4EwT+S+XM3rrodJWQ4=; b=Uw0OTlA8CT00jD/o
 PvqZPiYe/pHMCz6jzqKZyUH5U5NJ4asG7+Wg6vTFBFasOOngxI7tJDqdyfKcF10b
 vWy7Lj/X9KVWdmF4OiedmBxKffD0bJA2N6Y3YFGiBeT2EChtdaxy0LezVHVkQXt1
 GTEvROVOGhPeOD7UllgRisOM4VhAW32AMi6xqkEn1Ac09/q7LITJYwjaUd6jfAr4
 3oxr6F6UwyL3X8U/tnyesgEvaTUGhXkw3xT53Nb3Yj8cHfPZsuw9oSeHF85bw2Vy
 q6YKU1xVXirtWMu554NiNaE+byRB9A3DJdpV6Jneo7sWL/zDwFCMbD9xVjWmoZjy
 D0SeCg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnutf4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 01:30:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so6497555a91.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 18:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784079009; x=1784683809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cEnBrQNGubCmFtquwfieGVpco4EwT+S+XM3rrodJWQ4=;
 b=PlO6s1CJobUBAO7g2gt1B32lXpZrKvA9jVK4yj+rdQQKorQH96mIgtyZE7D0Pn9EzL
 5ZaTZH6xP2pjHGK8ebg+srp4XpKLRkOHzp66uBjGuOfcdIThXQ6MykpS0vP1tGOPLPcz
 8RVyf2HRETeNKJQ/vk0Ks9M30n2yTPdCQgIYskKcVem8ppVoFpmZyj8U6EKy4Rfea0ZV
 2smNfHmKAJHy9bcGk4eN0bLrKyxkfvoXw1nIolxchmyLkFJE77elf88MGYpO5i1C0ayA
 Be8VP7vl/ZitT1+13hMmhaF2AomtzqhdOLV9RnXEMKowqLBbpWyGdfIZAmBbh/gLoZZY
 XCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784079009; x=1784683809;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cEnBrQNGubCmFtquwfieGVpco4EwT+S+XM3rrodJWQ4=;
 b=UQfQ0qyY8zuNXI82NsYyFImauUo/FpR7hzfKXHJlmqt3O0JMK9r9g0bFBqYFX1BGxA
 HHRdUakkHCM5a14Yozr4kMbgVph8GoEB8C4/SlVOomWHt7+bnqhr7QtTOmZ9/++VfHfl
 OU8QG2HnOg3VHz68HnBihrGnR2KZHj413mwPPq344/ydFn9hXbvdkTT5YYpDpPUpy1ue
 oyPNGV9vB/XaUqZbJ66BW4MsQYy91x2tUjPewL5LN4x2EdNg3Fx25OoxOjaupRaK3Sho
 OKY+UkdJWvNpCbEtCRupeJaCivRDLdQTokJkJh1W4oa9VobV1KEsRpHmgLhTGvCsVhwt
 ZSIg==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc1tKZHIcMQ/B2s/MzGLjkY9n0HHXDqElmHMxPo6qKOUjmfT8O/EiC8t21hcNTSGCF8WrtZJJ2IDSE@nongnu.org
X-Gm-Message-State: AOJu0YzNKf9Dk6Etjf0poaEXWbFBLNuEfuecD7EpLrYcONw7PYfi+QZB
 k+OVf4mWbCDg5W78CGbczNMatb2PuW84t7Hxe5IK54aOnHii1SJdWVBgKQjZ0kMM5Zrk8gwsT2k
 IZ2FDU0yRciweYvHh5Zb7SLJpYaR5pph8LXafBKTg9dwy6WRQKh6NH8LZAilSFTySYA==
X-Gm-Gg: AfdE7cli1OWWq2PXJAcYTzTX9xPNqSc7n3924ACJMYf3+SNv/fmbM5tFt/1hdj4XUvQ
 im7zpHB56MTq/cV68aWV7WGsrUVTnd56MhV1jdWdOim4XJO3VYgxS3Ddxqu1qkgAP9Cc8j8aKby
 AKTy8ODYUaPkKBLVxNQbTKVlRRCX+8Ye4xicM4sjj1KvvoPktcxp9obGv68EyuoL/RlcImVq3cl
 MFztJ6X8yKnhczsVQ7//A2lMQ885r5Pzh86UZkEq3vugIoIDu5I6ZZ3CIgZgbs0WM9p2oscx/Yt
 m+/3JcexVrW9QZvZUGG+a2BmTmZob1rSvjq7cDWpIFfsnzw0m8FooI7U/JXEcYysOqrXwQWbuPg
 es5P1y/AjYXJuaBeG8S3Ug9eIZj9974SgzCtZ3CmNUHoE2IMO7lCFt4qUMav8txDRqLcn3+jDoX
 SG41U=
X-Received: by 2002:a17:90b:530d:b0:381:1b66:4734 with SMTP id
 98e67ed59e1d1-38e29f69b40mr870990a91.6.1784079009318; 
 Tue, 14 Jul 2026 18:30:09 -0700 (PDT)
X-Received: by 2002:a17:90b:530d:b0:381:1b66:4734 with SMTP id
 98e67ed59e1d1-38e29f69b40mr870957a91.6.1784079008855; 
 Tue, 14 Jul 2026 18:30:08 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm91117484eec.27.2026.07.14.18.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 18:30:08 -0700 (PDT)
Message-ID: <7ce02253-5d2f-4bec-8f7d-9f22c3eaaf5b@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:30:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] tests/qtest: add L2VIC qtest
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 philmd@oss.qualcomm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260714155126.3509544-1-brian.cain@oss.qualcomm.com>
 <20260714155126.3509544-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260714155126.3509544-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EtIf0cVITR7654ZGEDqFLCCjoSDjkm_y
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a56e2a2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Ca090yY_mppZuPpcPbwA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfXyiw5GhaLKmxY
 T/SYMt8m+PDdBHwEHiGYKD0chVzxv4KkP8bQonMNH+3q7eQnVMT3jRhlG2uIlQVw1u2gSHsLwyO
 iZv0Ysa++fTkh1PzBfXfmDP00rjSLFzSSwV/e6mZ4p3iFllTSb+uf/Rz/VNFF+FUR4nO8QS+545
 vqCeQdn+LSFmQeA/dVb/Oj2yh2rDZinFtDQjri6EWP15ZK4NQzT/NpBXCuG2/V/E6WUnQHo60ZS
 7SYOBAJuV9NlEiSvmVY7qbAq97fwSdhP7nA+gOlo8ijfMjFdpzWcUJ6OQKervEC4YHWGK7zRoYu
 ldBHhuo7k4aGgtFauJ5PKjec6cYUW8vA4ex0/RZ+DHV/TFnB8gE1a1W94UGq0lhAq5J58pP/d9z
 mo5eppuwbAwPYYmG2WxxbGz5+tWCDwP4jCWSny9YXE5tsFFnH9PBdoUPo8AABlNfFuhlGtb7AzZ
 jUc+3CCL9nFUPQUi1PA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDAxMSBTYWx0ZWRfX4RvZFwAnhhuS
 7TxKCMyxag0dSz8xjTD039sCftnOq7T/p2JNsJmR1bnkM6ZJhiiZ1yOF0xGJ1cF24M8rKo9K98T
 3i6tum+6nApCYiFTtGUZC6oyYJ6McyU=
X-Proofpoint-GUID: EtIf0cVITR7654ZGEDqFLCCjoSDjkm_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_01,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150011
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

On 7/14/2026 8:51 AM, Brian Cain wrote:
> Add a qtest exercising the L2VIC interrupt controller's basic
> register access and interrupt enable/disable behavior.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  MAINTAINERS              |   1 +
>  tests/qtest/l2vic-test.c | 242 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build  |   2 +-
>  3 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/l2vic-test.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

