Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47FEC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyywm-0001tj-Rr; Tue, 25 Aug 2026 17:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyywk-0001sI-Ri
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:44:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyywj-0005zg-8I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:44:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PL9lr22020342
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FSiGeTmIBmMQU0rpAeuSVck6eErEvKbQJgGckplyQJ8=; b=fN9Cf/2pmFKINJbb
 dzGJOpH1F0IzeqZODElwOywNecvzO5tuWpALtW3ERhwc86fD9oJa5EOY3uKy7yHp
 Q3sdYLSkxCA52KYPSBx7E3gmfeBSpUqWiPzmAw3j1fgZG9oN34z2E3r6EIJleEen
 M67pg+d9enhyQ3RepHFIGlnhQQv1l+jnubm+fbEiFp+fMHOCRCEoEunh5Z7YbZgs
 QAgEORwRr/B2vrcqkm9tDH4+GwmjS8TsTFkqlTX8ProIaTSR9RaxahgMuABQX8Ts
 IKUqF9kvVduuz3oRRS/iG19Ufe/Z6ntcvPmqJvBoTVkDqTjKDOOWgpj+sNK/++2E
 7RNL2A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgr8v5e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 21:44:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9368b4c5964so2681685a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787694278; x=1788299078; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FSiGeTmIBmMQU0rpAeuSVck6eErEvKbQJgGckplyQJ8=;
 b=CNPrJRawwienCnaskcys4vZlKPfPtJ8tMzD44tLmpGLLfECWQ1jK68DPrCJPTqzO92
 7Cg8IWq48woml01OmvaG6fRBM2y5yNQtv76nXfg+mQGtOTdomg+E7tEBzkVpXihRp0Pc
 j3U8qC0V8N/SymRGt8XtZMcgmUVz1r/mccvv4kSa5GVrNZIs1flJ9vsJixwgAxTUc0W4
 wVOz8CwenYN65R2zaIpF2KQXfq9LyNbOf7xH+gROmrEBxFVdqNrb3tPzI3/MOo33f4Hq
 yyxj1M1rtprO1CbmdtffdMAolLMD2SQWZe5pG3y+ZSHeo5Scu4Gin5/88KjIcBMK311T
 8Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694278; x=1788299078;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FSiGeTmIBmMQU0rpAeuSVck6eErEvKbQJgGckplyQJ8=;
 b=aXX1tUcxhcfhD9mHfoe7pkk1bH4/XsQY/2TFinjlB3qg9ZgG+ZRwFReyPhCXgDi0qE
 4cxEaSDWBj7ng9bqh+u8yN3VCofeYY2cCuZRMG6Xb5tpeFq/mCKjOrlUi6++6oVejeMJ
 9SKzEKpiuNANTtBkhHrwp008NR+jDXIK8I7zKNrgKHPkIuhykSbrNuVLyhjD9WHcKj/X
 lagpzamvQOnPV47mQdc/TL/fiEVK1ycuH0paritejP1rZFK3d0HIR5cl7GOVpWKXR3rX
 jnBBCZrKoq2zIzcjttD7KgA3CbVfDgcwCJCsJw4sAGkae3lgrQ8nIVDqfRDP1cOHgbEX
 aktw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqROjuCq6YF/hCh/PWGSF2pddiTTYWGThXLVV2Dro7DDA4PsKb+7tc6Nu71qmUdRGV4bu/h3WGgkbEt@nongnu.org
X-Gm-Message-State: AFuF++nNhSlsN1DaTKXccyzYUYiTRKTkez9Og2+I5gbdrYNdUDoVtnV2
 VXtJtl8eulVwy93z0pwA7Y83SEpNB09rmlHJRyi58hQoSccxuBK03Q611wG9aGPnDoFRTIT5qrs
 UyiCIZVqd2SvWzsBYBnWqdQOrLFmqsrfMJjIOwRLPFPCY/wcwAgTHqXUOEQ==
X-Gm-Gg: AR+sD12bCcFp9RLAaBdnSbJK+bYAR2bEA9yw2djwKoE363p38VGIpPUYZ+tO4pQGd+l
 U3tjE/lbAd2/qKay8Dr5YZtc5QJOi5xcVsWDV3E7kQFG/CBGyRbPv9P2SOGj2YRSP0ZT/PaDgt4
 blZ8ExKXL6aOG2LDgz5ndxYoV+6FUpHB/2AgL8To9wDOed5Qh8SFfvCe2NoSC8OVi1CeUSFjY+i
 Qh8zGQbF6qY5/BC634UJLzxwaEjf2busMLCHRyY2wABntYO9XO2ZmiCrqtIz7WtsldSWbXcLwDX
 LbRJrSUNmqMEpIdyhPt4olsYoCaqJXJl+lZedD0qzdYDAtfmr5sJaPq1o3141MYv+fLVBExuNIj
 ftdEvcCBvFbixNz9+CqDbKKNJhHUFhBTN/LRDHZ/832hN6hiTj1U=
X-Received: by 2002:a05:622a:1347:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52e4226d652mr21813831cf.14.1787694278417; 
 Tue, 25 Aug 2026 14:44:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1347:b0:517:6d6c:187f with SMTP id
 d75a77b69052e-52e4226d652mr21813651cf.14.1787694278061; 
 Tue, 25 Aug 2026 14:44:38 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab569sm684803f8f.16.2026.08.25.14.44.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:44:35 -0700 (PDT)
Message-ID: <44589623-e353-4bad-8091-ef9c339683bc@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 23:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 45/49] stubs: split monitor-core stubs into separate
 compilation units
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-45-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-45-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7guT6Os-KPFz_WVVqzHVZ7oMeNeD3PBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX1HBTDSx3QwX0
 JE1uVaL6r58vbURJlBakZhYmtEVMWU73OCsBEPn0wFol/XRsYyE84f6mSIYxozbxg1J3PLeOtps
 m+iVXJVGvcuBa3rwNcKBUmSeLhzDatX6DiaiB8/72e7NNWuKSmb2XwRlDjPA2nYo5rvjXsYQz73
 SDgCdgMW8jYYiv9mI5zKbORl9mTsoYTO3+VqdXrFh74OkQtsPuAjsphwy4l4eLsap/N3mzY0ff+
 +9tkiNhoDP8sU2ByKN/BKFdUhtCkA9xugVtnc2XQOmUr/IduJwyriJX7aqoIiTjPv8c2GaSnHk2
 HUSvcWxKyyWHEj8dbxtMDI777I7VoEYUCwFGSxbtW8cJ4TSyNf84+D8LcEkhRPN1sQiKr+WzysJ
 2KJSUpHJGjTKSaIE65TkoZIRBjUL0Dq492QCjr8WBYZM8we+yaff9osybgG9ja0ZSpaMnzX1ILt
 3Y2QLC7F+J24/h9t4pw==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8e0cc7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 7guT6Os-KPFz_WVVqzHVZ7oMeNeD3PBO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX+B0ztjmPrYYw
 /bcaZWr/0Gm0Z4fwHGUQQU67UAL8UDB8QWqejOBIDrUqkmVokwx55QxgMFb+rQzmK7LJn9KWtmI
 PylL2CifunbN2Q5fst9ang05p0Mhs2o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185
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

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> The wild linker rejects duplicate symbols even from archive members.
> When qemu-storage-daemon links both libqmp (with monitor/monitor.c)
> and libqemuutil (with stubs/monitor-core.c), all symbols from the
> stub .o are pulled in, causing duplicates for monitor_cur,
> monitor_set_cur, and qapi_event_emit.
> 
> Split each stub group into its own file so the linker only pulls in
> archive members whose symbols are actually needed.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   stubs/meson.build       |  2 ++
>   stubs/monitor-core.c    | 16 ----------------
>   stubs/monitor-cur.c     | 14 ++++++++++++++
>   stubs/qapi-event-emit.c |  8 ++++++++
>   4 files changed, 24 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

