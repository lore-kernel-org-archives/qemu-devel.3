Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB23FC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOvk-0006Qi-At; Mon, 24 Aug 2026 03:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOvi-0006QA-AD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:17:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOvg-00082R-SJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:17:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5RM812058379
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZGp99OvpJrv0rkSxZyGICzr4wc0xJi8H2s7w3KhPu7Q=; b=j/Yi+ZnPjKrKydRh
 DdxX3c46m3NuMgUe+5hoO8qyu21qeoV7eE5MCThmGpJfSDRvlnIFRh5reCIOKj1o
 ecaXMkgTGsjlUf4kuPbCRSLLmGt6YOkaJ9ztMlGRhcC+OFEvUEqpeWS5iueGyhOB
 fDC7zrE6FN1XqGzlGF/mTsKLLRITigYEvyRH4Ed4qLVBtIHYtpVpVbboklnThiVN
 kXLM/ChUUoWuAaxmJgpBtCPuuImvjXsnPsWgVJtEbt9GGUqNUcHw9zwoiIHA6Xov
 xJO592MSVYfavud6WeBpMgBcsx1awbUjGFki7f9pvr+mEkVn+9H7D+8/i5GA1wv3
 jELCbw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr151g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:17:11 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c59f5dbc9eso955699e0c.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787555831; x=1788160631; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZGp99OvpJrv0rkSxZyGICzr4wc0xJi8H2s7w3KhPu7Q=;
 b=VxHyyl3GWYhedDM5xWoWbHk0ojUVCrZALyCcp+DwuVNZK0wfYBkCNsB0PZQFdMDaML
 1zX02Mj5+oLjgPWc0lsymX99MF7/XXUlpwLqXjyH9EyLQjprdQsCkz+xTghZoIdAYfUy
 p9ERtWEGaJ7pueLOhrrUNv7N2onkijz+3o6yMzOPqn+2b9piNSd+Gkj2e18FCCg7YGbC
 tWmERWWc4dvyLijVaeljqEUUiJbHvIX5nm032ZfaACovSU3XOIidrhoyLyOSGE0yVTPt
 EKsxy8z8BXgzM2gsy0nLW6ECd3Zho8DrZZP9+EX0tJEGHriwUf8AYy3tS4z060nFGwPI
 UpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787555831; x=1788160631;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZGp99OvpJrv0rkSxZyGICzr4wc0xJi8H2s7w3KhPu7Q=;
 b=cfW+gK7MM4a4RaSzVVAcuqJTLJdhSZ3HLICk+dfhBhAnuvgiYtSDTJg3stwYJoGjjf
 1Lw6rjhLADfSO/npuzI2vjJZJUps4PwbInIq6WaAR2ZOJUKZ6alY0UupLzSBcQVVLheP
 uU3C2PiGRIJXHjKXnqcWpxOBfuX3SihHzY9vNOf2nPh20bTCnHUGi1nAyPPahkktyVhY
 QBFEkMD/MIvvQX8329oEed9QP8rDvdJdDzMqczYwd1+J3JtBQ1B3IS6x9Yd3f360l7rU
 cBXb9tnW8+FyI2FJYeUZE4fGrzI9+voe7FHPhUuk6zrSFEsnS2oah9rZNewlgRWApokn
 y7GA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJT0/8D0p+C2JkjqRYxMoTZXEIX0c2fIt0aQxKEA/SHMA7SGpzL8y56c5wu4823mG6ljwjgdbpJ2Vj@nongnu.org
X-Gm-Message-State: AFuF++lIT79rwmOLGqCAd/mOcTMJ+px7JS9fdvtkxi9ArYLPQK9WN1mm
 JSzSMxuYSQHUrsm6KGTtIs/szEb6MFRTbLVtSMqhsMXh/yE+KItv2CJt1/GVcOWQMn1u7glpw5Z
 6NDJ9xFhXZnXOW+2VW4Qwfqdf2FdLPXRlRfxFGJ/Ecsd3Jyda13SmNKcITA==
X-Gm-Gg: AR+sD121nW60wa0keFdmDDhnF+rYuV3PEl9PzCl8s7nvQjnplmbH8SGqx040uHWuT37
 AP2zuBV9KX9hSRaNGAfpTgCkhaWaISMaSgca+SAyojLOU3d1H7jMbUHN732w2olGpFlZ7sEmUCl
 sAJ1TY+eMxPLfaoWCt2OCgK5tAzeQzNQ3SXCpSJyU19OgnSi98oYEcxDdBlDTm907hMLeATy2I3
 cQTdicl2mhMKhB4nOo8C5omjIT2uYB7cB33iKAWkjXNwMRaFu5WLLdtyR+rp6c2camVOgzUZCIm
 jnwFIXEhQ7X6ms60qQZGogwlmst28jbxAqbmwK3h0u2UYIRP1MKYqb+/mRHWvdrrcP0jtBfy4rG
 qyRiIM0KC0UXnZA7w4ccCghdvEC9eX5o58p9p02uleNCV
X-Received: by 2002:a05:6102:304f:b0:777:ab3c:b88c with SMTP id
 ada2fe7eead31-77bd1e98b20mr5122212137.8.1787555831019; 
 Mon, 24 Aug 2026 00:17:11 -0700 (PDT)
X-Received: by 2002:a05:6102:304f:b0:777:ab3c:b88c with SMTP id
 ada2fe7eead31-77bd1e98b20mr5122195137.8.1787555830633; 
 Mon, 24 Aug 2026 00:17:10 -0700 (PDT)
Received: from [10.254.188.74] (132.170.88.92.rev.sfr.net. [92.88.170.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e199ad5sm7081590a12.18.2026.08.24.00.17.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 00:17:09 -0700 (PDT)
Message-ID: <9312c014-7c10-4fc4-87b2-4e3daf42fa52@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] qapi: update type hint for types_seen
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-5-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824052859.880475-5-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX49KuPPXO4qvw
 ShKoIIxj5oLgNTuMBS9xi0g4EDNFRBMrW+pydTLMiXJwbDs/odYGvO67ZgW0H/Ug6Tv+Cwim4LC
 ruVXnMap/VmUAGNynqaQNAL3NGpGogWdSlev+dQFB7XfswSm1Ax8ges/PykDxEBbtCCTnk9n5Y4
 OeSw8s6iUdzAGcnAgc6RqIPtS1bV0BadZ50SyxYz3uPQ70zUWA5+BtVLyNz4X7s4VnGeft5JJqy
 tGdCVNjopvc3vs1u8Q0Pc2ZZD2V3yp/aOPtYZ9F4fu8esLZpacLL/HVmDqpif7thsxRDUWIq1T1
 lAnc2lu+/32T37JrRjKyKobvCKOiRWS1agHViMOtMyeF/dYV2KwI11Mbhn85+p6xYJUS4R1Kdjw
 jIcePP0NrllNSuYcx/6Q1i1WpqieZKzVmJAsb+ySkCEA2JVIG/6xHTqjZkSlARVzo+OqMQKTeiz
 +Xb5AR0KTIqxVEYfD/w==
X-Proofpoint-GUID: qTBrJeyNyC_2CEr-GE4wQaBnvBVXjbf5
X-Proofpoint-ORIG-GUID: qTBrJeyNyC_2CEr-GE4wQaBnvBVXjbf5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MyBTYWx0ZWRfX9N5DQ3yGAaXL
 axRz2XqiPOVZ3CO+NIlNNKVy2vvCeJ/z0HwGJzMlfzKv51ACceirsDP1uUaiqu4RwcaUBK93Yac
 e2OFDKyWgKEIYhaezZ2QK0V+xDfEdIo=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8beff7 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=k3i2zbviP8V9/5wfVjyM+Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240063
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

On 24/8/26 07:28, John Snow wrote:
> In preparation for upgrading Python to 3.12+, adjust the type hint on
> types_seen to prevent mypy from chirping about an unknown type for
> this variable.
> 
> Why didn't this trigger earlier? A mystery for the ages.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/types.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

