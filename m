Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3573CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQU1v-0004V8-18; Fri, 22 May 2026 13:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU1s-0004Ub-Pg
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU1q-0007Tp-Lb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHUULZ312895
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ruJbvrxNN+yljx5EHf2RnV408cZCYmyQyf3dJLm6wlc=; b=m6QLPVb4QLzmDUEN
 YSFW0LBeNJSXQZY1xVzrQTvm0r3sO0ad3qTwSonHVRNd7XdDSzEf5Atd8guWZ3Kt
 KhcDiW+7eRhGnswZcww2i/X2jPfoMLRGhf3So1RRPUvzAFFTAfQrUyv1GrspmasN
 288scWw3mXGxJJvUqnrzlujR52pFGQGAKHQP+NjNADGZ1zt8s/lkg5HfnzG7km3q
 ghB92shABNOCt6hf0JnlDv5v1kGzjrBlQWtJZ/RjKteRAAO0/3DQqoCzvs13whqv
 HIcQAXYJdqYCl8iWhx0krRnm/gk283EOtFvwV5e//BievDWLdxN2TsSnvQTN2KDt
 AmKeYw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea88352df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2efc342ef15so9406546eec.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779472280; x=1780077080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ruJbvrxNN+yljx5EHf2RnV408cZCYmyQyf3dJLm6wlc=;
 b=IZl0DtdG1vC/eR8O1qCv9iyb5zCWnYPSCfCF/F0iEPptCVkJ27EpkfKH80BR7GksO7
 FeHxVLT0aPjJa0hV0OyWCCTkjlhPhh2xYjIbJxSlJJj3JMm3HhovwxnpCVLEpRDUINR5
 zuenR1c3fkTnL+4DkcvY6Z63sAkSbRfpbGKAVRzRyy1VVOOiqPfahQ3z1vOQgSaJNmhi
 UeSJDDIkPJ7lfHnADIm7OZyGMZdCRyd2QyRhKOFlMP69mfhlvIj8A3QXbnEy4FxgesWQ
 hHnDORrJvGUIyrgz0NncAq7aRtjz6bs8mCXkUh6fHZssIJMOZv1FfjlJxoqVOZJ9SgMP
 EOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472280; x=1780077080;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ruJbvrxNN+yljx5EHf2RnV408cZCYmyQyf3dJLm6wlc=;
 b=Y5rJD3G5KddysSj68Hyksl+D6VOnpehFXxP6/t2SMJmz6c5r3TUGLqCxOeIzbAtFQA
 PMmoLjyctULvUqpqPGxXZdPhdD83cZQsAMAQQklYgQEXNjeONCmfduGdBQLD+rjidI2W
 /tvW3n43cLNJ4poYdvRRLQscVUA1soPTkOb244HrREUF94A2egeH30Dud8yyZO71VNgT
 AjvZ+81eRoaloz24gn6E/+G3S7WzHcMxse/9eiw+0SwAISOHWfK/Kf745GMP7kyoxBeo
 vW+JD/boBO0wYXUW2dUmlnrkPZsqxnmtn8WSWZS0EPwMFeU7s1spwufJFvyus3OnFb92
 Xk0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zk0HzwMH7O0yFQYACKTNNXy7omt/rGEUixJbF2CGN5T0pmEVK2R44nhSTOY9Fjktmn/1TA8dye9b3@nongnu.org
X-Gm-Message-State: AOJu0Yw+/BipwK75optX2hh3vcOGA8rFhBUuVMaiQAnrt56Ip9P0LgUF
 sRaX6U7Z3+MFtdYv/n65rTgKRELoBBPksiFUQfddAh1K6h6K6WUQh4iloIKhK76ejX50RpZhsg8
 JmQdEEYguPaFtrqNHCfveQSJrPLt7Fckos8/zi4TenIAAXcTalCupAzE1VXARusD9gA==
X-Gm-Gg: Acq92OH06poN9Urfn7JL6PPhFE56Oswnl2WG3MP6BczsB835vBcXGtGFtcjvlDZYyWO
 hnxhqL1TRMwQSaN/odOTJI8huycvkhU+izxKjvl+TLx1+qptMbtlZTEVDYuWZH7NZu0sPrKtp0V
 2i7EGeCJnTINpOepfBiDI23tA7L/mJAL7PAmgoLU/V/I2d5edzhqTYAwLR9uiKHmk8hmFX92uqA
 WYXRpH9bguILnPF9S7AkMeR3g+tpxk1Cw9saqOQucrV6uqcmkblFFbAPiuUjqyAihXSHA9WuXc7
 mqvKjKoswHjL7qmMS3K9r5NevGF9scFaAcXz/GuNyS/IJGoXcNu2jHUg4ffvuf7iiRDcpxg5mOp
 IW0sCRfsgJ/3wdm30ufZMl+7jHt/3TzlsGduVvpmpTqdilpVgx+MirkvyQv8k4z6lymltiUuVye
 NbE4PWjEWtKY5Ugw==
X-Received: by 2002:a05:7300:ef82:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-304490b808bmr2282821eec.24.1779472280184; 
 Fri, 22 May 2026 10:51:20 -0700 (PDT)
X-Received: by 2002:a05:7300:ef82:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-304490b808bmr2282788eec.24.1779472279646; 
 Fri, 22 May 2026 10:51:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef3273sm2037879eec.2.2026.05.22.10.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 10:51:19 -0700 (PDT)
Message-ID: <6ddeeff1-f0d1-4f4b-aa5f-6e3e198887a5@oss.qualcomm.com>
Date: Fri, 22 May 2026 10:51:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] Makefile: include tests/Makefile.include before
 ninja calculation
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NyBTYWx0ZWRfX6MmraJa36Oqr
 Wfn/xSjVOjimFZghtmVR22m6ZQ1AY99VgUHqjb4W7Wf27QvxvZaKV3h7lJUSksmfVbd6hgOLhLJ
 tu99XkknRPXqzBbJ3WxQVEAyyF3u+bFGPUwcA958RQCLSPbW/mSlVb9iDq9izd55lTkAU6R/TUG
 /TiBqoHvnH64Vhw1N3KH/2197fM7hjqgSL0Sm/JiFKbm5WYoKuyAfj8AugyeHeJIFMl3aDbMsmg
 rFBToKk1GRe+HvjdG8qgyyTT9RuSwiAkDH37gFT2zNZZXokO4muB3SqIxo1VvZMSPWzWpOZgQzU
 uVr5XUAMKN5hC5UaOotvR4UGOIKGKI4NIDv8TNY+KpeRyaaKSHXcdwO1fXaHA90GlDv6chOQF13
 3t5WMTcWjU/1Cebws8SMOQkME/n6WyVmkARjWoxC2T1Oit1PvV7+AXVExXqUCeWeWniD/9VehSn
 GVpMJu0d5saTvxYrOng==
X-Proofpoint-GUID: 0-JYRL4J1RtHk4ttomtlVmxYuXQszIfM
X-Proofpoint-ORIG-GUID: 0-JYRL4J1RtHk4ttomtlVmxYuXQszIfM
X-Authority-Analysis: v=2.4 cv=LsSiDHdc c=1 sm=1 tr=0 ts=6a109799 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ap8Ps3bTL7ZImHDTBpkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220177
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> As the tests Makefile sets .ninja-goals we need it to be included
> before we do the calculations in the main Makefile.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

