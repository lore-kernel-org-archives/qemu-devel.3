Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D327FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wICNf-0004dD-VU; Wed, 29 Apr 2026 17:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wICNc-0004cp-7P
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:23:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wICNY-0006b3-Vr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:23:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKcD3X3677454
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ZworUhPZjgeOC13IXDb4N5dUyf+bK/R9NsR1dAiogQ=; b=H3MrikuAI0mmT+8N
 Bhjc7qGNUPGFPLpqjR2spYklNTDVN8OhChbODjHeWJFvkgBF/uGg5Ln8kdNW4u9G
 s/zy9z1skaL/ODLMDHpdMURKytjEL3+vt1inQNaKSfUT5vchiS0dLqMQvn5t56oN
 0EOxmm++tS8TDgtamHhQEQ+ea+3H82jNJgLnTJVwpS1qZR9bll0jnVF2Iu1HdLK9
 AIMY9C7/578fQdV1AOQjDSGr5Q/Ge3N+cvHZE5IGVJaHpHGh5WBRkVfXyukg5MWW
 YtT5P6lPR3U9vIF42rkT+jCBg12DTePtbMEQViZU+ZdHeux15SABwZ8s7UIXXcmV
 53IzZw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dua7341gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:23:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2e60238adb1so1016898eec.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777497810; x=1778102610; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZworUhPZjgeOC13IXDb4N5dUyf+bK/R9NsR1dAiogQ=;
 b=ZdakNBLQsgu//sQ55qDLp7EwA5YksOH9G5f36RBhtVH1QusM+SLuwU1d5aioc48D8O
 skxRwwmZ24stqzxknR0HKlXe4VA1XR5C/IN8PcATTX+yY89v1m/Ba0Bx3yKehQVz50O/
 tWnFxHG5wCsUnWgxhIBuwBMtRlbenEU89817Lhzb1RZXyIiqVmNpOOvE4CX42dpYT2BR
 u60SCHk6yxyZMghqMPbLYSaqZJVoZ4hcxDlDce9pdafMDLBzavQJGl8ZDYw3yl0UOcLk
 zkBziaJN4RAfWSH/6RUFxqRW68uGa0chJDG/Qj0tjeSuma1PWSmACpxm2I1EVHa9+SzH
 Ib9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777497810; x=1778102610;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZworUhPZjgeOC13IXDb4N5dUyf+bK/R9NsR1dAiogQ=;
 b=psjHnL2Qcmrp/NLvRn65YPIb/2TADz8xQK1XDGIWgjrvhoV+eqzqraUvq9QFFhqRj6
 zOJWNJdPage3E55O0ZIIFs2oZcHh0a1PAlJg9uAJmuBdYLM8UG9rFxXAKGtTV6+wNo5h
 H3ah+DP7PrV2GcuFRVVSokGvkOYNgwx+jjRVg3DgB+9Ab1MUl4GkE/8pR8hSbPnR8JPR
 nWDs0i5Bu0iTZDGvXe8k0e1f/6GAFk5juGPjCvdLFB/cHntuf0KyALVMO9q03BGhEHAW
 7ruxPiae2Si7oHqO8NrFghzLjYUHwGSVvEQPIWq1dtDQEpKRTfsjGAYbYa3QuAFrXq6I
 Y1cQ==
X-Gm-Message-State: AOJu0Yx7owdx8qadULdFOOvdIV3A7D51eJAgAJhPYUMtq6eKQF7b1PLq
 /EB0lw4JrNACIqd8lQ45qtzVYyNlmUytur4tedRxCBv1W0bEYfmoH8/Ajvl9A6cioXBBs/4zFMH
 j+PHtGhaOMhJzKMLcX8xJx0CdnRerntM9CS/0EUUhFprRZe2o+997O3zq9w==
X-Gm-Gg: AeBDies/aL+AwZwIkhm2WvQZUF9QYTYMl3rgWZ1+b6rwdpAjbsfu0iYXmQhcKfRH5qi
 5Z1qXQU6a2uJh7Dsx0J63UYy+O4UkfeDRsPu61MLKIJbHz3S9uZaaH9okMJg9zVFUuewJdOu0DS
 Zq4qSFBMjRkzJAzsidzxlwf21ri0xISQp61t6WqbQ2xL9XU1jq+QXsbnb3fGRvJWIMx6RtSJGYP
 aPPZo/VrvntV8ovehLHWihfQ/faNiRzqZ2cdytOC3X7+sdsUwGqI3L4U4Kwoz/6CzNhqBmS4OM1
 4DtR3ADRKedHazQn8XGFTjbkjR4uT3VXQQYaZOdmKAg4/yniFBtNaXuEWX1euQVFpMeSOD+ASqh
 fBgrz41dKE3aWE7EqPLxpq/No/JPFplAqqMiw/sYYKqoSEmqb/7ZY8j44WBUpbA3C089So3QxsJ
 SHAuJFiJ/yCJM/U8XahpUSXKDF
X-Received: by 2002:a05:7300:fd03:b0:2c6:1557:9997 with SMTP id
 5a478bee46e88-2ed3dea97c7mr6361eec.14.1777497809996; 
 Wed, 29 Apr 2026 14:23:29 -0700 (PDT)
X-Received: by 2002:a05:7300:fd03:b0:2c6:1557:9997 with SMTP id
 5a478bee46e88-2ed3dea97c7mr6335eec.14.1777497809482; 
 Wed, 29 Apr 2026 14:23:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c09b911sm5467445eec.23.2026.04.29.14.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:23:29 -0700 (PDT)
Message-ID: <daec20a8-3a04-40cf-bb87-bdbabaac3592@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 14:23:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] system/vl: initialize QOM first
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
 <20260428234519.1812371-4-pierrick.bouvier@oss.qualcomm.com>
 <177745176384.2166241.6921788598496135839.b4-review@b4>
 <afHFak0kkt2fiL0P@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afHFak0kkt2fiL0P@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XtvK/1F9 c=1 sm=1 tr=0 ts=69f276d2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=NQbTydNKjMGMIdwCQ84A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIxNSBTYWx0ZWRfX+OD5nwVQ77un
 YF9HupLSrzB0u/DlpLQ25rLTSNAKOrpoLpZ75jLRwG9MuZjdugT8uNXNORdglAy8yEfjkxVIqfb
 GD+EEWNZ35xZAjygAr6MVUys+xQem/EFYhl7ZuN37gVXU0CCf99JDZvDQBgRcxRe3Itbs5cB894
 2XRPVQKC542LYSnduTFpji3crNwv/XvKzjYyTgiHOxJByyE+uaggJXvrjxt6ArCYtoZozCnzGGy
 Et8t6HlE50DNtfntRRfpxE/SiQksT38VZZPfjHclbYEV9SFKBovilIXc8TwkF77W0xHI97rRBRz
 zZxn3bJHu3uRXCQwE7hhIoiAwfadCHmwom/5TxgNvEDp67oMB2k8dxa5WpVj5QAdFHhbj+VxsqA
 0pcuAz/K2NCYqqxlZCLbFKdGz+hea4x77vFpvsB3jMYtguEHcMGUE8K/YkK/tDTDfXG9fk5rLTx
 kYxzuLtRMfNHwq0K5hg==
X-Proofpoint-GUID: szJmxh_8Vr6AJpCUlhqfNLLtyLHa3UhQ
X-Proofpoint-ORIG-GUID: szJmxh_8Vr6AJpCUlhqfNLLtyLHa3UhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290215
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

On 4/29/2026 1:46 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 29, 2026 at 12:36:03PM +0400, marcandre.lureau@redhat.com wrote:
>> On Tue, 28 Apr 2026 16:45:16 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>>> diff --git a/system/vl.c b/system/vl.c
>>> index 0e1fc217b4f..b4a5ea6f857 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -2889,6 +2889,9 @@ void qemu_init(int argc, char **argv)
>>>      os_setup_limits();
>>>  
>>>      module_init_info(qemu_modinfo);
>>> +    /* We need to initialize QOM first to detect target */
>>> +    module_call_init(MODULE_INIT_QOM);
>>> +
>>>      module_allow_arch(target_name());
>>
>> This change is not trivial. By moving the call here, we lose the
>> initializations from qemu_init_subsystems(). Verifying that all
>> type_init() code is safe to run without it is a tedious task. It might
>> be better to introduce a new MODULE_INIT_TARGET_INFO instead
>

That seems like the right approach, thanks!

> I'd be inclined to have a MODULE_INIT_QOM_EARLY, along with a
> type_init_early(), so we're not presuming target info is the only
> use case for earlier init.
>

I feel that if we need such behavior, we can introduce another step when
needed. For the current scenario, it's really target-info vs all other
types, so it makes sense to reflect that in the name. Thus I would
prefer to follow Daniel naming for this one, if it works for you.

> Regards,
> Daniel
> 

Thanks,
Pierrick

