Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16782CD37B2
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 21:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLp7O-0000dG-B9; Sat, 09 May 2026 17:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLp7M-0000d1-Kj
 for qemu-devel@nongnu.org; Sat, 09 May 2026 17:21:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLp7K-0000Hl-Tn
 for qemu-devel@nongnu.org; Sat, 09 May 2026 17:21:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 649KqH1n792531
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 21:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2PtSrwP6at8fwIa/l8Q2slLJoZinmsk79eqKWH0mMWs=; b=ep320irrPm3A+viy
 3MiAFZcSauKJEr/86H/B5MSxpSkxmC7wfC7+F8I9KZc2Oae1NbsWAoX1rtA/9/QY
 y9nHe7b06HUEd5vrMp44WRdYlFqzbBTR+adcd4b4NuZxO7R/JRFclTrSV44F/WVa
 QBJ9cOJC8wI4ZiPSOoQPkH1bFokvPEzNpNC+gWwSQ6jhExb6XAkGBAQts+QE/7Vy
 weQu8LyJJ23NYZM14whRTXwPRr00V1g7BgjRpvlue5nELbEW1Ebg0s4LlMeH37Lm
 bI7WVqko50FLkLAr8ziCmqWs8Jj3GIDwbfXksATHHbWwkj4yThiH0xkLOk82qu1w
 LZWyXQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e240h0w3x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 21:21:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdd327d970so1868300eec.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778361702; x=1778966502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PtSrwP6at8fwIa/l8Q2slLJoZinmsk79eqKWH0mMWs=;
 b=Qm2MInKV2pkE3bg6WFh07qnpGlooPmGjcIASHLFmOqj9zF71sTG0RizP/nZ/UzuZXX
 b4CKJr5ocyt9ZqraWC+/creJUA0iu/0OGTDgzt2O2q2KzLOrz1D886mZGucdxw+S4XGf
 untl6yW5Uwa2A6vFSDrjUAb4R92jf4eTGKbhlRmQ4TrhcCvZB/bsoBSjddICRaT44lm4
 VLCZumyZJ+FSzAW/yqX0fwQXfFVl1ADhr4iGeRah/fvfzw0bzp4TO1lWq3rp9fQO3fqg
 h8oeybZquy3eiXO23wlX9QsmCz2psc7+xA452NEMBPPiLAkEPs8mmdIqZJAkIaDNECDA
 yCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778361702; x=1778966502;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2PtSrwP6at8fwIa/l8Q2slLJoZinmsk79eqKWH0mMWs=;
 b=PAAgqSvf/ESB8dKs5+oskGnTTmDcbS7UA6hUIZKkKq0Pk92xKBKVgDERg1Ut0bEmBP
 gaBPAVi8ew08GkT6BGnha2B2JpCrEI8Jv5hNTud9z0aUtNzpx9EWlaA7zMKZYAIzbxgZ
 DOsIEtaNGj9fTMeim0MZtCYAb8eUaVNllCUIQ+PKIrsXdGGQnbY+iUZiRvqSD9f4rBbe
 m/9YCiwtqcSsEhgQ8F2fkfUDsN5cgK5Ev50ce+eCCzEdmQsbVLjpokLRwc9tCh7GQkxu
 7Xn9pyXddgWat+rZbAaBvqqFghEQaypRJcKVpviT5qBSXcwNCprR1KZkZl3GBVrw5dXo
 yWuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WT8cmtQSZ86r5Ojzspey12YhwLBZjnIXBKiXHcT/+6VB/3/a2qlkR1EJnIBVBcbjdiDU7xgjk2PK4@nongnu.org
X-Gm-Message-State: AOJu0YxVlswJ+9Bvm2uqofl76C+BMs2s0qaG6Ss6nraS/f7azmFIJ4br
 zTlhGnmG/H+NLNJArvsg9LeWlWZ88bn3JzpLRTFhQqF9vkG0NQBx165ekK11wtdoOkM2MuykzRS
 9sbcixluWThc+Tgwgjnkv3izG0FYuqIpNzXyAI7fAZZu1maZpOEuqp9anjQ==
X-Gm-Gg: Acq92OF32VvNi4TZmjZtnjs2iS92zdwnwX4+KtY68XFaAabEwP28ZCTIUwnnUUZwYt9
 jXRRcC+3TLOXUZ60oui67/jCZhmyC3zv6vqc1CxjQdUE0VNU5sShoA5SjvKsuGQaGUGY5ZSku4K
 EHkucUrdUr4/QIHpipYiV3ngmbqFsT/GnAwudq0R3CE8d++NhuD0Rym9iJG3Vb586zyUQFz+iy6
 1eTmIdfb+pz/nAC+ru81qyEIh06YDW3/he8oNMRPPc7wXwUG98p2WWfnYmkEIGZBCKAPa2miec9
 1RzPt7hzBZR7yr8+ybr+peU65ydjLFQYD8p8AlGnVKeVp59iktyq94Vbhd7Hrgmt6U2fhvwmlPR
 oSjTj5848K4ewRDwdj8Uym3wyz9NAvNycLUyFea8gKsyz9jDOdZlxmuvDs46oYr/TsII2p90Ndv
 n3eNaQhxSEX31MCQ==
X-Received: by 2002:a05:7301:4593:b0:2de:e194:5fb1 with SMTP id
 5a478bee46e88-2f6e28f615emr5890359eec.7.1778361701946; 
 Sat, 09 May 2026 14:21:41 -0700 (PDT)
X-Received: by 2002:a05:7301:4593:b0:2de:e194:5fb1 with SMTP id
 5a478bee46e88-2f6e28f615emr5890338eec.7.1778361701208; 
 Sat, 09 May 2026 14:21:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e381c9sm7266839eec.26.2026.05.09.14.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2026 14:21:40 -0700 (PDT)
Message-ID: <0096021d-1d1d-4e6e-9a87-f924c62180a0@oss.qualcomm.com>
Date: Sat, 9 May 2026 14:21:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] target-info: extract target_info() definition in
 target-info-init.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
 <20260509005453.3984184-4-pierrick.bouvier@oss.qualcomm.com>
 <b60572e5-6a5b-4477-a16a-ba20d0585716@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b60572e5-6a5b-4477-a16a-ba20d0585716@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDIzMCBTYWx0ZWRfX8/kAWDO2ZbNR
 UdQN0E5Aw3AmjPO7fDEapR7OOBJ/mIJPuYCyVYvCFhf2ZkINjHAgXLQDbN/FkPlEB4amNjtR9Sn
 HwvvzPNyznq7Nky0q48EyXQK6rlIATNW7GnZAWOZ9vRc0bsZSdsdrEVja0oghHgX6TM6v8Cre+M
 Uhjo7V6qXy871FsAGWSZipy2c4EoWBb9FM+HZkvbPiA2t/NqbugaYveaBatPh7aQH0Dv2sB7emc
 zLfqJUiSmEC3BUZ+AzX4MzwX9lXJD1E22VCZc4wne6xEmzMo7/CVR8W5jm986+fyjxcvv00a3qP
 EHyDF8uJ/CE7+u3pT2cXDeXvnVnjo1Z5PIHiAmEZbS+kd0Fqk5vRl1BppdSupsixrMZbpS5vJxc
 QE35E+jbFUJL/lbBo2RnmIcCJs7pKvEpdNK3rvjY8kVXIZcXe1ZzdBELmqpNORpECzKYqd2ISNv
 Pv2Xi0saOj3EP0A67CQ==
X-Proofpoint-GUID: MDO3AzOY4UOPT0h7wwNu_dSPfwCWYbef
X-Authority-Analysis: v=2.4 cv=X5Bi7mTe c=1 sm=1 tr=0 ts=69ffa567 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Wgh-S_aYKH-1Mgd5_KYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: MDO3AzOY4UOPT0h7wwNu_dSPfwCWYbef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_06,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090230
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

On 5/9/2026 8:01 AM, Richard Henderson wrote:
> On 5/8/26 19:54, Pierrick Bouvier wrote:
>> +#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
> 
> I guess avoiding TARGET_NAME can wait until we actually build a single
> binary.
>

The point of this series is to prepare this now, as we already have
other patches (not yet posted) to link several architectures.
I can name it target-info-target for now, but I'm not sure what we gain
from this to be honest, we'll need TARGET_NAME in the end.

>> +typedef struct TargetInfoQomTarget {
>> +    TargetInfoQom parent;
>> +} TargetInfoQomTarget;
>> +
>> +typedef struct TargetInfoQomTargetClass {
>> +    TargetInfoQomClass parent_class;
>> +} TargetInfoQomTargetClass;
>> +
>> +OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass,
>> TARGET_INFO_TARGET)
> 
> Since neither the object nor class are actually used; you don't need these.
> 
>> +static void target_info_qom_class_init(ObjectClass *oc, const void *
>> data)  \
>> +{                                                                           \
>> +    TargetInfoQomTargetClass *klass =
>> TARGET_INFO_TARGET_CLASS(oc);         \
>> +    klass->parent_class.target_info =
>> &ti_var;                              \
>> +}                                                                           \
> 
> This belongs in vl.c as target_info_parent_type.class_base_init.
> 
>> +static const TypeInfo target_info_qom_target_type_info =
>> {                  \
>> +    .name =
>> TYPE_TARGET_INFO_TARGET,                                        \
>> +    .parent =
>> TYPE_TARGET_INFO,                                             \
>> +    .instance_size =
>> sizeof(TargetInfoQomTarget),                           \
>> +    .class_size =
>> sizeof(TargetInfoQomTargetClass),                         \
>> +    .class_init =
>> target_info_qom_class_init,                               \
>> +    .abstract =
>> false,                                                      \
>> +};                                                                          \
> 
> This reduces to just name, parent, and class_data.
> You don't need sizes, class_init, or abstract.
> 
> 
> r~

The rest of the patch is the same as v4, I added a new patch (6) to
implement what you asked. I'll squash it in this patch once you're ok.

Regards,
Pierrick

