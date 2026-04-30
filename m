Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6747DCD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIWaI-0000jI-8E; Thu, 30 Apr 2026 14:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIWaH-0000iV-1e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:58:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIWaF-0005Vt-70
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:58:00 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UIcfo62481611
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GHeS/udXX6vBaQob3MOD1n/8dZbFX01HzDglj4PtmMk=; b=dgqASWqvvVBJ3Rs6
 4MtOGWagnq3ddvGR4uElfX3NLo5yKNPZQm+Ar8DzsgQhmTJAuara11u0anABD4J7
 RGNngSpzBJBhG4hfTyyV0g+H2CK6J4lyGCzv9Lh+OgLa74DBBdFipjgW4YAxHXOb
 SORLhI6/dn3hnULZD3gcmxHp6wmF+SnQKLObBrIIVGjQYnZDLJjFDKnOTEqYbIMQ
 fiF0rknXtZu505qcsIpe67xjf3dD13M8/y/m97ZkPLbzDv2Cl7phyoXIvj2s1shP
 o40RjV28QIKCsRi+mi4n6Sc6bMQ2ULAo/rQNfEe3QpwXDK+N6hUgUkY+RIVGq8Zy
 eSI8XQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7x6hqes-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:57:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so4289004eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777575477; x=1778180277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHeS/udXX6vBaQob3MOD1n/8dZbFX01HzDglj4PtmMk=;
 b=N8ntKCO5yxtoh4oE0ioeEiv8YXJJ8z8JZlC3dXBgU30iu5KP5JXksP6GoTUt5P9bss
 Un5piq2/Jb8yUpIy83YY9xzFIGWpaIKj246esBm/92b1xKf17ukHHpcyfDJhdd+GWagh
 PVeFMYjI1phnmEmDmtG5mZhCljGcbCFbyFJ3gQu0JCTBj1OkyrAKKfudyJcrwuTnlGAT
 jVvC0NWP95yTntq8ICDo+wb156F0dIhKZht0IrvcBLvOjQxIaGKbeZv+8rzHiDh92wQN
 xV6UPrrPoTsweuDkyRVIBfx/5ShuRBF9lk4/DrU8/9/XN2r3ixq8uxNMcuD2HDrt/Y+l
 7v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777575477; x=1778180277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHeS/udXX6vBaQob3MOD1n/8dZbFX01HzDglj4PtmMk=;
 b=bXsTki2ASJ0cffBvr/aLJXKlPi4MaI83DKvRgOYRhHx+t3RYu9x+4a2DplRpm2zL9X
 0nrqvF4PWCxwed0JEuX3d8i6owzweL5leCZWF8USbBgNJLrfeSq88mIlwIDBYzk7+U1O
 QnK64mrRaM7Rf0JOR1h2v3EQAgWL50A3MCwUCCtyFtta73NFwuK+v1iSyPqPRf4INUIw
 SbeS4DGYlbvaClnRFa3V9XxjFuhDMKYGg+WOConZPBum1DYGxve4I0NzdVk+Hwze9grW
 CHY+Lq3+9/5PYSPPY8d4SGRmdBhqP8ENuoPVqrv8G3qfQIXJoM4CtJXmPXCvC5SNl0h0
 sWkg==
X-Gm-Message-State: AOJu0YxFmopEvioXQl5+bG35MriHOqNRnuwTVlOjO2pO773lU9ooMmou
 8v2HfWfXB1XOQ6RBTWAKPlowx8g0NCltDKSilr5FfoV6VO5azSDaEUO3CEUMNw1qrgK/uvmpGll
 9Q9eU+MyauFIRWbP110RMk30wtBL0f+LWyNa0FPBOEjfkrYv5rN3zXkOMvw==
X-Gm-Gg: AeBDievGggqTXuTbgMVUVy7SXmvK1pcfryNzIK2fqF46bLNUmAKVitaxTlzjt8ZpFlM
 N7jlmYn7+fkWNsqVCctrMpbxmCFxDGXjA4Mpc+LwApc93FvQCUts+aAs/xz+DdcLf6ISdmDbCzS
 YXKfprj3Edju4QCy74CHj8OQgVZSkYl1KbB6hYK7LduSmkh3UR0dBbzqNMnyY0EgDli5mq7O6/Y
 t0NggTyiVy9Wgfa41GB3eTs2GA+tl3LtOiFsLQzOJ/myG+v8oriXKDpNLiVtGGiXZjpdmm4gUnv
 wCitw3PRLtBfkDKMPNlxj2IMlcsfJR/rVkzjAUwvz7JI/bVtq5rLFL9P4+Uw6QmQ5H1YmSuf8sU
 p2fe1hx7B0a+zNqPMzOUs2SFphqB978bKSIcfGxmV03wyrlxq0DhBwgWVrk8h2UnwLr+98f0blg
 A5hswm3SKdpL1BT//hA7WsYc/F
X-Received: by 2002:a05:7300:6919:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-2ed3d7b9916mr2153708eec.19.1777575476575; 
 Thu, 30 Apr 2026 11:57:56 -0700 (PDT)
X-Received: by 2002:a05:7300:6919:b0:2df:919f:ce59 with SMTP id
 5a478bee46e88-2ed3d7b9916mr2153683eec.19.1777575476054; 
 Thu, 30 Apr 2026 11:57:56 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3bc6a79esm1325937eec.26.2026.04.30.11.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 11:57:55 -0700 (PDT)
Message-ID: <efaa7987-f8ee-43af-a8c0-793ea1092021@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 11:57:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] system/vl: register target info types first in qom
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
 <20260430035626.3511676-6-pierrick.bouvier@oss.qualcomm.com>
 <afMBbYSwZcobHaUY@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <afMBbYSwZcobHaUY@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sCaxeuTetUs9w7dyUe5khBzCxnLtSSSD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE5NiBTYWx0ZWRfX67FKu/fnFwh9
 leS6/5P1sbHVfZWHZv4a8D/xY8lqhOYuSOqY0I/YVdwPoJ+n45rFBji8ojWuf8IwqKtlDNBjKCu
 2BhF/SzpzbVgreC7TlbsmsG2K8Qqu6Lv5dWoEYyjdiA7GZJnifnTpgcyLmEBrY7PyRD8rB73ZKW
 SPV5acqowfz2iw4Wc04Rn9W6wfOYMMUV+WcZDTWKGxtFl2weYGZvkZFNOr+yKohacUtq5wL8l+c
 bwDDvft6idJHG9zXm0qubKn6yKuIPsguNeC4/986tF+j7X3C1V1AnACu1ohYWmLGpVh+2EpopE1
 wuWtGcPzNdPy7ZLYNdDqDz7EJ6lA0shbdYEZKFgQCWdzaa1Zc/Tl7//O4S98OjnfEQpGRdE4IJl
 K4jz0t1EfZD/lcUl0Ch83IgkldxSovKoaZqgnylULa2Kce/kBYz+zRSFpLuLBhqZT7EyilHw4Ko
 Psve605rLogWehaOu5g==
X-Authority-Analysis: v=2.4 cv=XoTK/1F9 c=1 sm=1 tr=0 ts=69f3a635 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0_1-tGrxsJUxPedztfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: sCaxeuTetUs9w7dyUe5khBzCxnLtSSSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300196
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

On 4/30/2026 12:47 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 29, 2026 at 08:56:24PM -0700, Pierrick Bouvier wrote:
>> We will introduce detection of target from QOM, so we need to make sure
>> those types are registered. As well, it ensure no other types are
>> registered yet, so we can safely call object_class_get_list.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  include/qemu/module.h           |  1 +
>>  include/qemu/target-info-init.h | 17 +++++++++++++----
>>  system/vl.c                     |  3 +++
>>  target-info-qom.c               | 18 +++++++++++-------
>>  4 files changed, 28 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/qemu/module.h b/include/qemu/module.h
>> index 9885ac9afb3..fccf017bf9e 100644
>> --- a/include/qemu/module.h
>> +++ b/include/qemu/module.h
>> @@ -43,6 +43,7 @@ typedef enum {
>>      MODULE_INIT_MIGRATION,
>>      MODULE_INIT_BLOCK,
>>      MODULE_INIT_OPTS,
>> +    MODULE_INIT_TARGET_INFO,
> 
> Please introduce a MODULE_INIT_QOM_EARLY as requested in v1. As well
> as being needed for the base classes in an earlier patch, it is
> inevitable that we will find module scenarios needing early init
> over time. 
>

Done in v3 coming.

Thanks,
Pierrick

