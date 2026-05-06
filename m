Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29958CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 22:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKl7L-0006yA-E9; Wed, 06 May 2026 18:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKl7J-0006y0-RW
 for qemu-devel@nongnu.org; Wed, 06 May 2026 18:53:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKl7H-00040S-VB
 for qemu-devel@nongnu.org; Wed, 06 May 2026 18:53:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646GuAto1985753
 for <qemu-devel@nongnu.org>; Wed, 6 May 2026 22:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qLiC4bBEZue/zg04G1guNtconRBipgb7XOu1xBwiHw4=; b=pvbuVj3TC1hCGhNE
 iXNLBqbZBlTklp2a+rIbsEEwRIfnQEmhi33Gvl4gnii/msuEuzSNhfTM2niGUsVN
 Np5rRvnFiLLxh24vUrbShmCLYOIHRyfkxW8YajARWDvN2EBf9XgxX+cH01BLtVfe
 F2FC4n4SxLRa0TAfrZpm9lnwI3W8RlqNCffSlATS+toEnNW1vu2Pg4vWTS4zzCSK
 5ul2gchaI7erJYcvVHl+qKO1Ya5XeDBRsEGLp36pg00f2Ui7hWXvrXydIq0Nf2yu
 KWgMPIUQTFbi0rVEXFE1/KigguZF5x6AUecHxwSaWG9gUvJL90Dbmnc1E7iSTLoJ
 7XFEPQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp2sqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 22:53:17 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ba8013a9e3so375186eec.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778107997; x=1778712797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qLiC4bBEZue/zg04G1guNtconRBipgb7XOu1xBwiHw4=;
 b=ch2/CSAnyNiToiMHl9aSbYI/8wK+3U6nZ2jXVKvJ7vQIFXGYUqCAE0dsjiEn9FC91Z
 6ovhoU6PCVBprcLJn8lwXK9CBnwF6jhEA9b8b1jXoFNxwcBVdLVoqIML/NUySq2Xqw34
 Jyn+OmTNH4CEzyPy/7gNUqNLaESXlkXvbPZ6pYLTxYU5b26Ghh4bnNfH3XM4gSk3qOtu
 MN9AklGVW3CzVWYadEkj2jKCnxwSmchAw1tlJ2eRdYAD45RTYpstumokGQeJN+IRAgaX
 0WRqNKkgiqKCZqcwJl0cmr759yZXIcNgIScl4GTktObBUwl82XNwtSwgUr8OfJmjwdO0
 ylbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778107997; x=1778712797;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qLiC4bBEZue/zg04G1guNtconRBipgb7XOu1xBwiHw4=;
 b=MpAkfjbSoyJ2xeghwCqTetmykdMqL4S3qKWFMH0zhfoOasNJNJYk7HvmawDELKBKbB
 xyIfccAyzBK/jACIbuc3b4gcvpKS1oYKsD6eXWJHLtw3V4EjefbdHUs/nwPFUp/Evw3t
 4xqoQp50x1ciZcZQzoRubdSNVlvbjiaQUW/27OTs880XUdEMz5WxpTsGMd2XeietIyi3
 Aer6Pll6GaqTHye0ssXIYzUfmWu9f3wJpwxCMx32/casZiHpGpP6gg3Vb0+afK8kPr81
 fqv/yEw7hfyNEtfKNYV/s2fKGZ318q6ggqFX5XbzT85LVtnGoeZ32NrJXm9pOiKCu30o
 LYBA==
X-Gm-Message-State: AOJu0YwWgJaq2BSqxjT4lSsmAcpMMPJzV1DtccYrE0nm7aGYjKaIbAFq
 Gw5yo/qUs7fyeyLGdryvdjCGtLPlRE+WWvlHUAa+gmtoK5HBruAiNkNXZnCz08/NyZ7VZRzEG2H
 liDX7NIA/IOjpjlDOC0u3/LJXScS3S+3WNklwy8bC/aiA0FD9ZakwrO0Aeg==
X-Gm-Gg: AeBDietTQAsT/HIDNlKuSJmiBwUVMwTT9FnVQn51zqfdl1ZAHYqdE1mSFWE4R5zpYZb
 gIncKEX9cU5CXnmcoiT2+gBLUddnBRTMqC8wczi3f3q26DAw/Yhri64oaA4kNWmI0Ek0ZtWDW1r
 N+mizcLIXNPdB1pEmOwCMUITtXZjfIMSxiStBP1oqRhtyyCwQPRi5ZyWZcVyxy4amGAMnFQ8FBm
 GnXmDtyYl3TQ1OHx1T1STMlB968x2LBZuYQWjUJJJmyUVBymJqwB8PphMIu3CGCeUswcXvfarzA
 udyjNN3Z1yxbqjd77BDWR+ApVdeIYI8sjItZvPPodalnnGMDftulEvicALOCxAGuCh+Hg8HBOD+
 aWOnj8irL9hXSv3mehXyMhe/sp36EnFdYzPYFe5bc1HkqftJpKVjR82A5SGV2KhCmfS1O9TDOFz
 uI5eegM31ppXQllKunC5Fr+q2j
X-Received: by 2002:a05:693c:3008:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-2f54de8c6afmr2583731eec.27.1778107996796; 
 Wed, 06 May 2026 15:53:16 -0700 (PDT)
X-Received: by 2002:a05:693c:3008:b0:2cf:3de7:22ad with SMTP id
 5a478bee46e88-2f54de8c6afmr2583721eec.27.1778107996175; 
 Wed, 06 May 2026 15:53:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56cec58efsm5565885eec.2.2026.05.06.15.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 15:53:15 -0700 (PDT)
Message-ID: <1ea2bb47-8d37-45fe-b5b8-fe62f0c962b7@oss.qualcomm.com>
Date: Wed, 6 May 2026 15:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/codebase: add link to rev.ng video series
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com>
 <afsFdNbJQDFctL2C@hive.localdomain>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afsFdNbJQDFctL2C@hive.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDIyNCBTYWx0ZWRfX3w8Ngv6G7Nbc
 PMf24kkYU0jcJysrBK6W+9Kja8kQagSuk4OcgThME+zmbk/DhM5chA3q09U14lGeCI+X3Kw6pJX
 YqdbIfjXXBginvdqSYY+X8sEXHJF0J8KkCMCfxKcgOSL+Afplib37CN+ABskprkjYHj2zk7HTFQ
 RLYPo4mcc1CRNJq1FMKE7KZ+JzqQzIBxPvN3ilEVq28iGUpCBQfUoBqRhtyMPEIXKJhsFiL1fKV
 3Vzumibr/uY1eGE9PO93KcXYjMLveE36/tykBqghp9vGQedI46goVXQHa+va6OwWUwLncf5XuhB
 ViLGiYK0b8aDKWL6WTLsY3k55M2JMJwx1PSQJD2OkNoxg18MJvdFNypD934BryEtYobShHRP4qH
 yVeG6f7QpmAN7g7Sjh5dCP5nKndmGwRWq8LWcTPXr4ku6EN9kx1YsErj7ss4pG94iL+w9E4ilVB
 SgtRckB6tEJLvo+hOKQ==
X-Proofpoint-ORIG-GUID: XjxrkRsvpog5NN07j7T6jnOTcVn_3Isk
X-Proofpoint-GUID: XjxrkRsvpog5NN07j7T6jnOTcVn_3Isk
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fbc65d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=R8rOrJ6PF0qG3-My5voA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060224
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

On 5/6/2026 2:16 AM, Anton Johansson wrote:
> On 23/04/26, Pierrick Bouvier wrote:
>> Those two videos provide an excellent introduction for a new QEMU
>> developer, and such resources are rare.
>>
>> Kudos to Anton Johansson <anjo@rev.ng> for creating this.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  docs/devel/codebase.rst | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/docs/devel/codebase.rst b/docs/devel/codebase.rst
>> index f09307b8971..f065d7eee0b 100644
>> --- a/docs/devel/codebase.rst
>> +++ b/docs/devel/codebase.rst
>> @@ -8,6 +8,11 @@ organized.
>>  Beyond giving succinct descriptions, the goal is to offer links to various
>>  parts of the documentation/codebase.
>>  
>> +Those two videos are an excellent introduction to QEMU codebase:
> 
> Thanks for posting this!:)
> 
> For the text I'd suggest something like
> 
>   "For an overview of the codebase in video form covering user- and system mode,
>   these provide an excellent introduction:"
> 
> If anyone has suggestions/corrections please feel free to let me know
> and I'll make a revised version.
>

I sent the PR yesterday with original series, but feel free to send a
fix with your suggestion.

> Reviewed-by: Anton Johansson <anjo@rev.ng>


