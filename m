Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2ECC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHjy-0003yb-6w; Wed, 26 Aug 2026 13:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHjv-0003yE-Je
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:48:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHjt-0006G8-Vx
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:48:43 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QGujDO343347
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2J9MRS46O/je+dpcUmdhPD/bqkbPq4otQb178m5hL6E=; b=o/XdR1rr7clwgiuY
 icf04BPffY+aQ4YvqqggSxaDHdD1j2LfI3Dn/EBizr95YYGbW/fXTkeYpJTkm84c
 /L+DmCTwTeNHib7RbPQHcbNPxyWnUUM0tkOPtWJ2iTf1r8K1EMITxEVCR+K2eEB8
 27r8A3p/6Yqtbwus5cIpddmWv6zzVv+aHQmrh+T9yg/2RabxQo0cmD+aa80cXG3u
 24FXlMZv2tPAmnPkwskGibo2IRE9HtLqT0uSf7MageBEHbWT16vfng44S0qXTevP
 yCn95H4cRoJRPmhZMGEdq/50gheI+gX85D+2BicBKswZZTSb+cxxXRIF6WkhwEZV
 BjGycg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9uthtchj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:48:40 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52ee59064d2so2046651cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766519; x=1788371319; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2J9MRS46O/je+dpcUmdhPD/bqkbPq4otQb178m5hL6E=;
 b=DRiXCThQrE1lI+Js3+YUpPDxGgYpxAmpu++XR9m0wY72qjt/wtUBbh1hTOmBjvIAAn
 tObmVAjsj9FWGJxYKzW0owMqiocvp9ZdVVku72cvIo/xKbnSpZjH6ARi2EAavsDzl4C1
 ATUbr6p0mpvv41TYfmVOGj4JaeQ1nV10yPDHvdn09csXBiX1swp9HRWnJ1otk+aT8S6E
 sRrKuW6puYOXy8Tflb8pS8OP9nujo3NtO0i7O60pClA3weys5M3fW69Y1rq59NYIMIlA
 L3CJZKvvfxqX/moQlD9oI4zW3OQciErfCbJI6UvdgQ/rOsKmq4tMnO2VlSjxqh/YbXe5
 Sgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766519; x=1788371319;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2J9MRS46O/je+dpcUmdhPD/bqkbPq4otQb178m5hL6E=;
 b=UTZAHdSqObFb3cc/3Q6jU+GoGhKs2rSufQo/6CBtooxs8UPvVLrVUVksAls+zKTbS0
 IczjyCQ1qdgpfPGdT+6fdYnBYzFON2ixBttWMrzZhn9hhtSO73GDeYbkA7XozE5Yy/fC
 eRh1ncJSdI7pmZTKfH1OdYX4zP2Mf5w0FYkC/un8BPRakF6Pux1zjVVEEdcfhbQYCYWm
 zY7U2bPEqfEKqdRc4SwPWSXIKMP2KtrZIyyqmXJaGSiAmRDzqToKAw2SuRiS4lNeuG4w
 BpYMRbelzWshx6HpaNJmKjbNNivU9zshjAoaUFgrLhPvQkhwKuPt4bJtNYoNsays5+uN
 CzvA==
X-Gm-Message-State: AFuF++mYDO7hKE0Z5Vz3+9WU2WT6+D0H3uSTRvMfXqLA5/ytogkcgtAn
 yRm1zb4DZsm7MXo2lWv9cPf2DcuhcKW73j2GbBShiJMQJHZV1LGW/Dgd5X0oaVVMoHw2d2CvPbz
 KZNk6RO33Qi1RH4JhdUyBr/FB4hNECTGocQ1K6lot6M1ACvG12chGUWQg7Q==
X-Gm-Gg: AR+sD10PjdUqE+iSAqVAVeEOe77WKRnJMjCraGO53IYyrbEcWcjdrJ4j7wawCle5FmN
 CqTdSf9lVtvKR3johgE7X7Vo1FpbmtlJflRkMXrWobMnI1U/81svM8nZYTg1z4ew1QTcDDVxZAn
 sg911TYBf+jdi7ofT47J7CWoujkRtE8OOS30P4j/gjbnfx+mktINb1pmMRuEZgdacyOScZXYJ1X
 hez8D0NQWmJftN3kEpigcHSS2Zse63aL4gI0V1orKByVDo72JVcMyZR0aXNH0fsr9YFmVYKKje9
 SClhIwezS+ekHI4Fn9rb2l/cK9jO8GKYGC4hvme3ABY5OoV0OTriBona9tVqS4zsEhW8TOOucCO
 xv2bNCJqFbutqaM9ytvsYEwoAi9R4dizQoyEUD8CbDBp9
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52fa1a9aa93mr10156651cf.9.1787766519642; 
 Wed, 26 Aug 2026 10:48:39 -0700 (PDT)
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52fa1a9aa93mr10156161cf.9.1787766519138; 
 Wed, 26 Aug 2026 10:48:39 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d647dsm576835466b.13.2026.08.26.10.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:48:38 -0700 (PDT)
Message-ID: <741a5e23-c221-438f-8876-f31cb8d580e7@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/49] monitor: move HMP-only fields from Monitor to
 MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-8-af60857c2fbe@redhat.com>
 <a415e322-f75e-43bf-9f0b-beacdc04c33f@oss.qualcomm.com>
 <CAMxuvaxwjtQa+4N1_rTLK0PuefNCE3oTkkTFbGTaGi4AUcz4Jw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAMxuvaxwjtQa+4N1_rTLK0PuefNCE3oTkkTFbGTaGi4AUcz4Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a8f26f8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=GicCe4fCGamTXgkegDUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vg0XOFL_7vwckNcboGw1VC3OzDSst771
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX1dmSzOoKJOF2
 284oTsX0Rt2V+cmX8O2qVbxdArGSIGqx+grf7SzZaqz2HHqXyG+QyaO0rqNmzYxeTUv5iU3fqr0
 6jwMfoqLiFKcGOgBZBw2xbk9JsOvkdGnSJmongCQveRoU1iC7xUXMjeoRU9D4vX5jnVMpniuxJn
 I0j6OKsE7wtiIOKdtf2odNz/USLbwcpwelqSA0RjHBlL7jw+juPUSnrn1ywFndaFbBgFxqZk1W4
 +/ahqpFk2xk4RdAEf2EnG7oOAJBn4iLu7zTWyP9hQixPydGdctgKdLW/Iki7afzwj6zP0MTFlkr
 1Gj+hv9C2vSBhAb7FjACXWZdbMR07JMseNj8AYyatOJZta3mx/X5HiVYx2aqRLnpYz0saYs+5Vp
 AVtpYNT961voiODHZBWOsjwXXshTOZauDGiXa04mhNq2683HMqmILqJugsclD3bWrvEUWy8iqY/
 xA9Rkb2tA99MX+yxGfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX8VeiOBX27oRq
 MU4iI2StrUnzOVXb9bJ176OZ02n1HTxAg41FpaPb+DKFTXNqeZFaax9+sCgd71HxLFS+cUa+RqZ
 nEqo6LoiAblZ2YT3XqmxneEV2EnAz/M=
X-Proofpoint-GUID: vg0XOFL_7vwckNcboGw1VC3OzDSst771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 26/8/26 15:06, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Wed, Aug 26, 2026 at 4:39 PM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
>>> mon_cpu_path and reset_seen are only used by HMP monitors; move them
>>> from the base Monitor struct into MonitorHMP to properly encapsulate
>>> HMP-specific state.
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    monitor/hmp-cmds.c         | 16 +++++++++-------
>>>    monitor/hmp.c              |  9 +++++----
>>>    monitor/monitor-internal.h |  4 ++--
>>>    monitor/monitor.c          |  1 -
>>>    4 files changed, 16 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>>> index 6b1114fdaf13..6718fec97047 100644
>>> --- a/monitor/hmp-cmds.c
>>> +++ b/monitor/hmp-cmds.c
>>> @@ -499,31 +499,33 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
>>>    /* Set the current CPU defined by the user. Callers must hold BQL. */
>>>    int monitor_set_cpu(Monitor *mon, int cpu_index)
>>>    {
>>> +    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
>>
>> s/_mon// please
> 
> It is gone by the end of the series, I'd not bother here.
> thanks
If you are sending the PR this is simple enough to do locally
without needing to respin, besides that makes patch #35 simpler
to review ("monitor: tighten monitor_set_cpu()/get_cpu()").

