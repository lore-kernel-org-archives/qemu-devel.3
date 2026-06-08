Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB3ECD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdIW-0007F7-Sl; Mon, 08 Jun 2026 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdIV-0007ED-Sk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:57:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdIU-00014d-65
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:57:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFW2A3588417
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SC9S6FoyrE/v1Vl14jK/AJDKWBLC22XxmJoWmOQ9v5E=; b=YcxEd7bVblZ75sJI
 pDwo2AYBaAfb49RKDqkz+/xfj4ov+GxIOTHklAUDod+0diQegV2FYa2UN0wFlKQz
 VbqGbKvIa53YwMSTs21FQ5vqCR7agQm0h4t3wGf87IngZdDIMfj9d250gwnUcE8Z
 tKFwzlDuyZJFLqcmoGcz67+Bi1agrWGOJ5tEYR4TiXO9a647GOJoyVUUpxKIWD8K
 wkwhflNtn9hy1soI1fZRoZpfS4PUlfIsuQUxi2Ok1WLbXGc14Ft1DhyDRhFg7fOm
 oZauBJVxKwHDttiR72Y83Ij4bSmlM+u+3ybmIiq58CXZJKRGC+5zqLSdx4RGypm+
 dYpYyQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun41wrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:57:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ed777a96so2892837eec.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780937875; x=1781542675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SC9S6FoyrE/v1Vl14jK/AJDKWBLC22XxmJoWmOQ9v5E=;
 b=YICMlYBVztKe6e04iHom/hwsQoZ6/ju7zo5fDJIOhK9zWvuwqE1SO4QBAUg6+Az9m2
 eJthpQwc6ae/6nnuLFqDb0whm0iqWBPnWyvXMpr+EXO/ui63NvedUHMkLR1SQhKnAvY8
 z8j6lwTWAc04/3r1Jwlk3XPiJsdpHIqO6GnvmzceBweT85kKoJmnO2DuQ9SIa9T/lWEW
 mXtDgoiO8dPd5GEv8MyIrVHVAinWHaIJkh1INFKCEBw8Wq5l6fH+1DGfHoOTWSZPsIj7
 FiBvc2ZSLtiDazhc42VFTU9u84hZnlVNwK+BMeL8Xp4FR7kSOXJn6gFq6T2NmeMYq334
 aPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937875; x=1781542675;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SC9S6FoyrE/v1Vl14jK/AJDKWBLC22XxmJoWmOQ9v5E=;
 b=Ck8oUv/SZVCyOIEbfyuCe5ajDdWVKFxU6zbQZX4oN5YkUDMcyy9cxEebz+qvpaPPat
 Pq5bIvUxHtOX4bv7cl487YpwPCW6ybuVQp1gQ1hgaFAKqY+hHzc10vbQ4kUxOKuQ6HKt
 NgwTy2rhILSMTknT1/qRw3ZFQLsj6ol1mjxDf7qpE22y2qq2Nb52IkE9f7HcFTPAHLUF
 jeVgEwa759U/Arp2Obah5CmvrR4kETi5/2qdE4AiQhcQWycfxLBwu8mhHHB8ok2CP14J
 qT4nrybR5qJEJfpMz+SAKHBPs3KMl+uP7rut9vAjlypWzR1cqB0vuVqPW3+D2Lkp7OOW
 rmbQ==
X-Gm-Message-State: AOJu0Yz/hc7Loc5zFclmP/zvBoKj9uZLy5LT26KAGjbm51KnUFXz9vnU
 nrj2M971SxXOsszvFCgoyxIPg63EWq+fnb1I3JK2AF+gQE2s3llNDNljnP81CKLSBxFYRSVUY9t
 kZUHQy9Kwvfi11wNrKTNtuYFIzYQhsMcTYIBiNM/kTP5olzuEv1IaNavYIA==
X-Gm-Gg: Acq92OF5Osoez9QbJI9KBRi6fd/ftkDePZz/jIOczaVsgNTkhjWfYYFU9eibKjd9QS4
 n/ZrDpMO2N8T3GxB7lRIhtRJ8ACnyp1svdQKvhN45mgFFDBSHRur0wZbOLTyMsa8oVO/FnWQ5jL
 sbv14s21v1SG/3fXGUC9mEFS/tDAvUCc0rffv/esTE6OVcoRDlFKyagVI/a+bjYYc4UGhN6MT3h
 gEpIl+1sYY3VqAkzBRDucwY3h25vfUsTF2gL2kHeIHTi/Z8OI9mwj97TQcR1QzhJ5rFI9BLJ5Zb
 GQJMBc4H2UrxGklNB+TuajBWXlNsnLHaBg6aR7s9WOeZvQpFqn5gWZAHCS8eg3k+HSJa4lLOtZz
 RKfbs65wD/kSn/LTy+MhkNNziCotlSxKpuW7z0NsF2kr8BICCCUTiZ8uaxTSKXP8f+Hv8yr5C0T
 3IuYFpp0QZXzFuHbli0H3btnOS
X-Received: by 2002:a05:7300:7308:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-3077fd759bbmr7787399eec.1.1780937875505; 
 Mon, 08 Jun 2026 09:57:55 -0700 (PDT)
X-Received: by 2002:a05:7300:7308:b0:302:b44b:b64a with SMTP id
 5a478bee46e88-3077fd759bbmr7787370eec.1.1780937875013; 
 Mon, 08 Jun 2026 09:57:55 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df77a0asm18845642eec.27.2026.06.08.09.57.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:57:54 -0700 (PDT)
Message-ID: <aaa0daa4-9697-4a1d-a20c-1e3eeeb4f57c@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:57:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] docs: update mention to ubuntu2204
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
 <20260604215148.3769627-4-pierrick.bouvier@oss.qualcomm.com>
 <87zf16vece.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87zf16vece.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MSBTYWx0ZWRfX1JUieOCErv7N
 28zH2p5ynqRcQGIGzU7gth5sNoqOt1lWpPDznjvyeJB883bHn4cNDPUAGjo9+vCeYVUsuSEQy3i
 fRKhzeKu5gQCHUGfWes07EbKDCC+bne6VMB5ssVsVJ4ZRGW4F9qZDdpifIjm75X1C39ktTQCcYn
 Vv3Ax9GX83jDsZLxIJnqSIEFBxtA04FkTMT90/AfGPB5UV1Wr+nV69m1K2VfKLzg4tkpJWsURUO
 M2AY3n6buUV7fDiBgn1r/W5TlzBc48cDRo44TGzuYF2fUAF0xR4x45eAVyqgkTFcKXQbiUESQng
 o+OAZnmFzvy8eWb5x1WwuZjhff2OEk2sZbdmqXhASuL/IQF7DrFDSZfqOaL850JAMKBkV66MHW9
 273RjJ48qOoOC2RpkcL5lsN1ka039AEk+TD2ghY8Rw/8pGhpTp11J/zB0biCAPpsPXlJlm+NVTB
 ejuBClGu6VyB2xvudXw==
X-Proofpoint-ORIG-GUID: V3A3QLoK-t9slJySkhQOLkXZs4LNZ_xc
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26f494 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=YljwU6DbQfV9YSwodXwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: V3A3QLoK-t9slJySkhQOLkXZs4LNZ_xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080161
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

On 6/7/2026 3:23 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  docs/devel/testing/main.rst | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>> index 3408b5836dc..1a884da3eb6 100644
>> --- a/docs/devel/testing/main.rst
>> +++ b/docs/devel/testing/main.rst
>> @@ -711,13 +711,13 @@ https://github.com/google/sanitizers/wiki/ThreadSanitizerCppManual
>>  
>>  Thread Sanitizer in Docker
>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> -TSan is currently supported in the ubuntu2204 docker.
>> +TSan is currently supported in the ubuntu2404 docker.
> 
> It's actually a build dependency (or should be, I can see libasan but
> I'm not sure where libtsan comes from) .
> 
>>  
>>  The test-tsan test will build using TSan and then run make check.
>>  
>>  .. code::
>>  
>> -  make docker-test-tsan@ubuntu2204
>> +  make docker-test-tsan@ubuntu2404
>>
> 
> So we should say any host build container will do.
>

Ok. I'll simply remove the container name.

>>  TSan warnings under docker are placed in files located at build/tsan/.
> 


