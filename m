Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B7BCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIZFY-0008BL-OC; Thu, 30 Apr 2026 17:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIZFX-0008BB-Qx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:48:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIZFV-0004uF-Ra
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:48:47 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UGImIS2122425
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ztiKvTooEa78xZec/qi9tnTbceACcxUtdOMroemjqbI=; b=NcYZU4ZR7JcaVLsJ
 YcCpq7gdvaz0R1dp3JZJTXhOQPD/+zlhobTrp4cW1wNkJUlRQNVjnoSt5rtlzIUC
 BVxAGkxjMWjUta1p9gMfoMDmXs6dyeNVP8gCyfljOhGyUZH9Q0ENEyvZwQL+UIZP
 9OOHud/4aihkVl6qL7bnZOrl6EVctuQAEgT0c6TOtRHHj93ae4JtBsormKtgQfGs
 93jfUYljdPmBooz5Ibo/cj+s0TAs992mEFpcZc37d+IX3fWJ3rofG9P8zdN65SWV
 vxsShJ/LHYhVQlL2MtzyKrSLaaJtQ4JMb9VDvPj2HI2V7qcYdDhJAk4PACx8zWpH
 rWW9vQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4se8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 21:48:43 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c20d5d7f4so6447285c88.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 14:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777585722; x=1778190522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ztiKvTooEa78xZec/qi9tnTbceACcxUtdOMroemjqbI=;
 b=T9zAhHLdVhHPr1Qdekm5Cv8PxWwjDIrZutmh0bqJJqxgvXGNF8enVZwClkD74i24zR
 3BRcrayoOcEu93PLuXHaEsNX7Mri7XWu6r0v9KwkP1bxT0cyZRQC6olDyb4y5ihffb12
 6UeN7mKxvXDc3/jaGrxWu50JDF6b5WXqC5HI77fNkLJXjw2Lbq0DJt6QDf+bzOeYd2v0
 ZCSSqmKtNa1/XGp9Izlr+3V0UBsnFhBOp3+8KFbwAot4xvlDIAaMhIEUTM2l4XHjQb0y
 1swzkcf1dg3OryKSREuDmhoSd04sSKiNOxWKYSI2fVAstHxxCNRJB9HKeysHfQGS3G0t
 SJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777585722; x=1778190522;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ztiKvTooEa78xZec/qi9tnTbceACcxUtdOMroemjqbI=;
 b=jchwnpS6PrzB7EYulre0kRu5AGSSof7Tk6j7OqP6ee+rnGKD3gyUOazQq/MD8sNtWg
 1CqryUuxqf++yAumKjRtzvOMLZhoCaNfXyHFW9Gnes9QwXaxvrcq1oAilCZ12i3xhM1b
 +Zt2aRBa0shFtX2EeyPP4WRjBU/M4KnA4H4zCFwxDvc219Y9xQYM+ti4lLxw3LPgWVmr
 WonyeGip2jOsxE/DH7Q9yqGHB+zQlGIfpKaUZZz3cn2Gh9EOTKG1YUJe+deOClTCfhnn
 GJaPSrOfpylLjvDtgHBjZGW5eRt/VRBiJeooo8XR4p4iKmOhorSZa+nyGLuYt/ouazLT
 EyYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qpcm9H/uyY2ocrqIQip7kQneuXY7nF0I18jG9JA7wsIkDjSHemwK8A7+5SRAlWtpDHFFSVRGWpwKy@nongnu.org
X-Gm-Message-State: AOJu0Yxfgk7yPiQD5+/Zx9JF/ue6EH8DP5Tj9KAWp4b2+JU694VqVxrU
 jrra/q9BxCiKIpqgLDEaWYTSCkD9UPdpjvd80w2W+Y8Egpa4bWRoB7tZgqQRS91NXDButCPIt2T
 dEAi0MYbDqd2HDQrl4EQ6CB9o6BIskKRE+iCRbV20afLGW4JJWtqaDEGT7g==
X-Gm-Gg: AeBDiesXMbI0XadYRe/yXmtLAjtJ7J+Q8A2UKKm2K7Ac3rTpt2w/OMOSPKW4YWTQ7va
 sCPhQjm/Vsp27R726tXF4RHrYlmI9t9F/jAeOdinukfbwzKFzxDD6VAQ/5GxplUfHVa9bVMJjF+
 ZLLjpMKzDLrM/0aHBvaQ5Er0BvMCH3Sg0+5z/COpwDKDZPil5f7sHQ7amlBGGtK5JsdpD18D/Qz
 di2JUkFYbf8hJ7s5Arc/HgTZtQq1uhou9jIFvhYtUQQdmf8ZubQtM9jsw/lA31NIAZrSbA42mJE
 GqtZBe37n8LyK1GlzQbvVIhM4uEZRIzVYjq4OkF9VvDXZYd+8ouQZvj5EGN4wVLHHvkucL0UxCh
 sxcovoqimKutl/GGGIEZnM7SBJT6AwpfvyzN8DA3+zAEUMtrw4rWStpmUbsQPJjgEbzu2itbKLQ
 5jALawKOVZY5UbghbIZ5bbRWTD
X-Received: by 2002:a05:7022:207:b0:12d:ca31:f1b3 with SMTP id
 a92af1059eb24-12deacadd84mr2534724c88.23.1777585722361; 
 Thu, 30 Apr 2026 14:48:42 -0700 (PDT)
X-Received: by 2002:a05:7022:207:b0:12d:ca31:f1b3 with SMTP id
 a92af1059eb24-12deacadd84mr2534702c88.23.1777585721765; 
 Thu, 30 Apr 2026 14:48:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm2590669eec.8.2026.04.30.14.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 14:48:41 -0700 (PDT)
Message-ID: <1592077a-28c4-4575-8f47-8b3fbf49c112@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:48:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] qemu/module: add a new QOM_EARLY init step
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430203842.29156-2-pierrick.bouvier@oss.qualcomm.com>
 <75c8fcab-61eb-4c27-ad10-0180f335e85c@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <75c8fcab-61eb-4c27-ad10-0180f335e85c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MgEVopf_nlb3xjHLRPH71wRyKothu14l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyNSBTYWx0ZWRfXxkTWnxOnQuQn
 uRQNsI+LCE97CDhiVTbmPAQRodSFQMRg8Z25CR9vszJ1qc0t8MNl0P/a4lAGBKdWiXbg0tHA8d5
 7/zXl+oM/tj0mUwWS6h2PE85vlEw6BlkaebR0Sa97SYb1lmJw8tpbGDkcYYnUkkUQaBCALyQXpK
 0vsTMX49RRtp7jgflF93pboOkqrW43PPtNiWbm4FRlSmBwxSL6Mp3/9Xpu3vbVk+H+o6IXiNK7c
 eAVMzUxwz/R2O5lFtZg8XtfucTfcvirEB7KdbUdogIiab9cdt7Msqud9xfUOSWab5UCXV2LCUkG
 9D2dyDuIKfAsUuXXm6+iYDVyp3kgRTKdKiyk953FuzW3EMcxuapVZsY7pVVPpGrSqfjitar/ntI
 yJ/eUda7oEMBffqTyggl4ZBJ5GsrxiFj2zc74LD81mApqlO66y3cXR1Wy/HdRh7poBLwsJP+AOf
 czf3qK2R1kYOvFrQouA==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3ce3b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=taVGPX0Qp9d0wdHB2QcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: MgEVopf_nlb3xjHLRPH71wRyKothu14l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300225
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

On 4/30/2026 2:11 PM, Philippe Mathieu-Daudé wrote:
> On 30/4/26 22:38, Pierrick Bouvier wrote:
>> This step will be used to initialize fundamental QOM types, like OBJECT,
>> INTERFACE or TARGET_INFO that will be introduced in this series. It may
>> be used in the future if needed.
>>
>> We need to patch all call sites to module_init(MODULE_INIT_QOM) to call
>> module_init(MODULE_INIT_QOM_EARLY) as well.
> 
> Just wondering, could we add some module_type dependency, so
> when module_call_init(MODULE_INIT_QOM) is called and
> modules_init_done[MODULE_INIT_QOM_EARLY] is not set, then
> it calls module_call_init(MODULE_INIT_QOM_EARLY) first.
> Modifying module.c for that is trivial, but I couldn't find
> where to register such dependency (keeping module.c generic).
>

I was not too fond of introducing this "early" concept precisely because
I felt this commit was going to be quite ugly.

If we go down the rabbit hold of adding such implicit dependencies, I
think I really prefer to switch back to original INIT_TARGET_INFO and
static registration for OBJECT/INTERFACE. It's simple, clear, and does
not require patching 50 lines in 40 files.
For the last 15 years, QOM didn't need any early step, and now it seems
it's a new mandatory thing to be future proof.

I'll let Daniel pick the solution he prefers, between current commit and
reverting back to v2.

>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   bsd-user/main.c                         | 1 +
>>   include/qemu/module.h                   | 2 ++
>>   linux-user/main.c                       | 1 +
>>   qemu-img.c                              | 1 +
>>   qemu-io.c                               | 1 +
>>   qemu-nbd.c                              | 1 +
>>   rust/hw/core/tests/tests.rs             | 1 +
>>   scsi/qemu-pr-helper.c                   | 1 +
>>   storage-daemon/qemu-storage-daemon.c    | 1 +
>>   system/runstate.c                       | 1 +
>>   tests/audio/test-audio.c                | 1 +
>>   tests/qtest/bios-tables-test.c          | 1 +
>>   tests/qtest/fuzz/fuzz.c                 | 1 +
>>   tests/qtest/migration-test.c            | 1 +
>>   tests/qtest/qos-test.c                  | 1 +
>>   tests/qtest/tpm-crb-swtpm-test.c        | 1 +
>>   tests/qtest/tpm-crb-test.c              | 1 +
>>   tests/qtest/tpm-tis-device-swtpm-test.c | 1 +
>>   tests/qtest/tpm-tis-device-test.c       | 1 +
>>   tests/qtest/tpm-tis-i2c-test.c          | 1 +
>>   tests/qtest/tpm-tis-swtpm-test.c        | 1 +
>>   tests/qtest/tpm-tis-test.c              | 1 +
>>   tests/unit/check-qom-interface.c        | 1 +
>>   tests/unit/check-qom-proplist.c         | 1 +
>>   tests/unit/test-authz-list.c            | 1 +
>>   tests/unit/test-authz-listfile.c        | 1 +
>>   tests/unit/test-authz-pam.c             | 1 +
>>   tests/unit/test-authz-simple.c          | 1 +
>>   tests/unit/test-char.c                  | 1 +
>>   tests/unit/test-crypto-block.c          | 1 +
>>   tests/unit/test-crypto-secret.c         | 1 +
>>   tests/unit/test-crypto-tlscredsx509.c   | 1 +
>>   tests/unit/test-crypto-tlssession.c     | 1 +
>>   tests/unit/test-io-channel-buffer.c     | 1 +
>>   tests/unit/test-io-channel-command.c    | 1 +
>>   tests/unit/test-io-channel-file.c       | 1 +
>>   tests/unit/test-io-channel-null.c       | 1 +
>>   tests/unit/test-io-channel-socket.c     | 1 +
>>   tests/unit/test-io-channel-tls.c        | 1 +
>>   tests/unit/test-io-task.c               | 1 +
>>   tests/unit/test-qdev-global-props.c     | 1 +
>>   tests/unit/test-qdev.c                  | 1 +
>>   tests/unit/test-smp-parse.c             | 1 +
>>   tests/unit/test-throttle.c              | 1 +
>>   tests/unit/test-vmstate.c               | 1 +
>>   tests/unit/test-xs-node.c               | 1 +
>>   tests/unit/test-yank.c                  | 1 +
>>   tools/i386/qemu-vmsr-helper.c           | 1 +
>>   48 files changed, 49 insertions(+)
> 


