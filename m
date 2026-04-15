Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7148FF4213F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 18:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD50b-0002IZ-U8; Wed, 15 Apr 2026 14:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD50a-0002Hr-4n
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:30:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wD50Y-0004eS-H7
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 14:30:39 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FFoYTG4052561
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=; b=d0xFHgoPGAWGY4L6
 c7Zi8iYnnZfveSVHOd7hc1pFKTi2TIVTvyBUduWCLEh67mzGuuV0L+WNDO1iH6I2
 G1Sm+wYPJTttIsFn1F97lzcHwc/GeSujR6FL/maiehUmBop9E/Jp0FHFfq9HZsWs
 SnV9F7dT31+BmG5C1l3puftUWn1yW/bNIENLVDsMrJ/PQ9Cgck7ayuCs6loqlxiG
 OjY9aOfSXMEObmDSiKGzegu5qA4t+4S46xlmCWwg1XkxSCNfCv0Pw0ERWB1rh6wa
 X0vs4IV51XrbbdeubB14hKAJFQLHT68R+Hfjic24TvPoeRpQPtAwkiK0CMt78aA6
 18CO+A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj7s5t00y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:30:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2dd6fb4c867so5599645eec.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776277836; x=1776882636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=;
 b=jfiCmoyFqMdi5RvKw4erCeaDZWNoPGMrfNajJshnbsu6P1SDQAgTi3APb5qrNb+aHB
 hISsehUKHTyPVambgdbknD0XKwgjYiXLN/OsrKZK3yZ7df03nianxAZnKWZMEaruz4EI
 SOsy7TLAa4hnms/FQhblexiPeD+1CZYoO3IKibB5sdMojb5HI4uW6QDxRbovidWJSYZ1
 r+7lhP1l/kmcxlgWHf4ScZrRFlxaAN+8CZDWecqQGtRMbn6sCn8Ju+OR2+XwDpSXE/5I
 vvuuVV7DTZj2nesGrf4JT+ZyD9E7BCKfq8HBS3I4yxqQIpqHEhZj/GeQrz0DROMVuYRc
 BdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277836; x=1776882636;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fl+1tl0YSlSoPT3I7t8TEcqocRT9NfBgvgQEn0k1Ylw=;
 b=Q4aMDHJZRllOEFHbwi2v0H5EEacXVe27QH4Aa6W+f4PwlZbpR+tSi6tO2gf6MtnKGI
 wFQq3OMd2hVclX/SasFagD67XV/RdolwB3+UwZh4SM6OBOcgGia9JdWnE/zFKleckSXF
 uzKIKYXb0hsatR1b83zkbajZDpcNaEQbGVNuYmxz+76/7GqcUG4ELq8zjkOs3cl2X5VI
 qxMbc1t2zOoB76hMTrtZeOjRkHaWyQHSEvAXhewwoKbSb+abXK0gWc0s9dYvc3qY/0Xq
 G36KSPXTmnPTsiPsndk3+Jdu2Yqp3/sBJYTHj+hwZXsSS74IuME3Rbl1k1zOSej6y0Zs
 Y5vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p4f9MAaVL909MY3PLLaXTw7GXDt0iqaCQV27YP1bvejV/4eaX6OaDgLbhj3H2vKjoLYc3NlLe7Vul@nongnu.org
X-Gm-Message-State: AOJu0Yzbc3zyOx6WcQTq2HtVE/4oCGm3hVHmWEXuoTft76YDHA4kUPq0
 iJILeu8etU+jg5vyqmiPkSthY4iqlUWJSWbAIdWmH4CCV0ZrLdFvwovNS5Iw2hGNfTsilzDrFkI
 GgYIrRQhLK/Pl2iLDVg2v33V0f68qAE3QUL9QTElJ0Q4mlPjuqMczEd/eOA==
X-Gm-Gg: AeBDietcYOCEeSjanI7S32rYmrrVbSLpx7ubWkFzh72qIpAghj/4+ur4k/FtOhWKGaW
 3lM6RHvZmau9NuzUQZM+6tlfwLGvU33nKu9U0F37VznaLkpC/WpoFq8Glz9BQd8tisI2sEKeR4x
 Tqk7AVLtmLebc4aw0Zlmty3C0kAXh5+u8fW8Cqw7sf88JatZYyba3clt+rgGhhPSOhPTXToRUUT
 hXsNbmRLe1wBpKThCtURuj0tVnggmKypVcB0HiOYf7YaVSCQTv2vTiBJlnSuT8/n9U2iQD0k8aF
 zGMFnU6c3MTglaR6zrzWAEkoebRlvW0kDXhDxCQOHtHnLiqXX1DWG0XhcaEpm5Av4Oi61l2RAsA
 eHsFt/UIFhXgpmjcuwpUQihVLZa7okh1wRC5qNgUiLUQcjGlqkYw0IV96+bSV5U4EgO2u35BPQG
 P1Fig6IFPqMQ==
X-Received: by 2002:a05:7300:d4ce:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-2dd5641154bmr3878765eec.25.1776277836386; 
 Wed, 15 Apr 2026 11:30:36 -0700 (PDT)
X-Received: by 2002:a05:7300:d4ce:b0:2dd:5641:ef2 with SMTP id
 5a478bee46e88-2dd5641154bmr3878738eec.25.1776277835851; 
 Wed, 15 Apr 2026 11:30:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606db2sm3683595eec.11.2026.04.15.11.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 11:30:35 -0700 (PDT)
Message-ID: <f74f30f6-14cc-4b4c-8331-dbc2c196792f@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:30:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/27] stubs: Rename monitor* -> qmp* files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=A7Zc+aWG c=1 sm=1 tr=0 ts=69dfd94d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lK6l18eX4yI4KgfliCwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 70gWEWXgmpcAWopyWEAsvVIPWF8O7A1L
X-Proofpoint-GUID: 70gWEWXgmpcAWopyWEAsvVIPWF8O7A1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE3MyBTYWx0ZWRfX2wcAqALQj9wt
 RXeFLt94aKhtohzIC5tnarNtKy+MT69abUi3icRg2PUAPgJ3NhxGzLHqI7FNymJ2dcZXF77rc1Y
 HwVQ60VT6BAbdlbhX4k5oiGI6XFWGlEqgQE67vpyBYFLYnlS8cHK+sk9QmYOVY/RgLb4Vk0t6wS
 NpcRpoxSXVmSFMSwMSRuWG5FKjthyui9NOXYHX7QLIWxoGD5Zx2AO6ncaL4tZxDbUP0oAe7/u4J
 lKcdF5iYWQ+y+U5eQQomjeiZ7IBh+GIE3Cd5IL+udUisG3nluwNwSJdNMGbIjC9UOU+Bg6XTRKF
 6sccqEKnzh6tEMGHR+08N2nPO4e4f1yQVrLu9Lfk2Qx8Jj+IwHkc8Oy5zccvYloQnjj/EZ0UmDH
 HIgxxZLcoZZPieBvH0/m77Em9YlBKihLXcHFlf4x/x+pSsM7d079JwoBrnm2IXIvAY5jJlcG7li
 o39ZFZdrihT6clr6Asg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150173
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 4/10/2026 12:53 PM, Philippe Mathieu-Daudé wrote:
> We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
> These files aren't about human monitor but QMP, so rename them
> for clarity using the 'qmp-' prefix instead of 'monitor-'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                                      |  6 ++++++
>   stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
>   ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
>   stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
>   stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
>   stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
>   stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
>   stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
>   stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
>   stubs/meson.build                                | 16 ++++++++--------
>   10 files changed, 14 insertions(+), 8 deletions(-)
>   rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
>   rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
>   rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
>   rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
>   rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
>   rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
>   rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
>   rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

