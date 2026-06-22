Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49738CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhMV-0003xA-K2; Mon, 22 Jun 2026 12:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbhMM-0003wn-OE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:18:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbhMK-0003Pu-T1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:18:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVnQQ3842514
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uvOjtSPBcrz/Hem07Zd7dMc6hhJvk4L/yoUtR36kktA=; b=GHivFOj0ovjYKEtd
 kfBjZV3GYuNpoN/NwYjOheFngJYkNLWxfp2jkPOU9U82wECfPb7YPpBUTmVSr+2a
 b+1z5Lq7RnNbKHpPlsz69c8WlChlIbod3Itr+LGeMBSa+D+Iec/pEx2w86IpuVGN
 hz5aAZY9ljwSMMg8pWxfh8PoSSvDXfadfIKYQI3LmknxNK2VPCJPIWlrNq7wh1HB
 Mor1tbO+A0gW5jJwwQN/0FFs2QWZEeHSqCi+A7SYVb4ET0xCknJ26yvNiRoWKr1w
 quWzGPJxjz+Ghy0aM9Kx7W7QTpb6U5kLnTTZyKk7P/4KNzJL8zBGaeWAeUyoT5af
 6srB/A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhsba4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:18:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30ba395b047so2419057eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782145130; x=1782749930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uvOjtSPBcrz/Hem07Zd7dMc6hhJvk4L/yoUtR36kktA=;
 b=P9OgJLmG+rcqFS0nOYPEiAE8fq4OdrWT9DHrW3jHta4I2NNGql+lDEJlSBQ5P9u/HL
 JWEUzv5xoK6Qbo7KeWvzhrjdG8sROfdmhAV8LVhFR0l6bLJ1XzM26Q6tQ6x2bDFKLmOE
 gjKCC2IQkNLC3rlrgQrAhCJAlHd3g0AoTNargL2yZ+urzB82G7bPiASDZazxznry9kCx
 /sQKSKG9tSLg3sCkXTg+toqx1JUPQn3JDCINOJy2FC9kunys6mTAjAnowPZkQDa9q1Ky
 2h94lMh2COp9Um1kiG72e8S0PtVni8xaWH9/dSyrqFUyZaG/5UqdZKRA5/Q61hl0FYLt
 mxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782145130; x=1782749930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uvOjtSPBcrz/Hem07Zd7dMc6hhJvk4L/yoUtR36kktA=;
 b=ShDvKGet1bscMXRz+k0UfYS9pF6tCRNO2CmwjgUJTYJkkjsBehJG7BsdRtCi/2C4J0
 EjnRUi/Ga820TkqPGu7nbkD4PU5jic1sCldW0guUhl2Uf0byntaqt/6jhp1u9MZxYunT
 PDYpI6QQ9V8C0D1RJEJBplc/09QaGICFfRVfHNdu5YksAzUTNxL4LB6JpHtGyx6UHlM9
 vsQisG8AXpzSw1Uo/er12y+jx2tyZoBPXQXI4DLDaPxDfwYOtSOaPiZWet2kcRRLHZZh
 p4y/mU+tpD5a9wrJ/zlUV1b0324aKt5KZlSL1M3ivp0xnajv8ljvOxOj+Of+BeF6oL0R
 zWGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3HUhcvrT6eiRw56E90xd4BsJ2/HwMlpWt2LgA2pWq99ue1mUhKDNm/o8QFrQxiAcInD1FmX4FJkTk@nongnu.org
X-Gm-Message-State: AOJu0YzYS69myRQD3fLiXRH5/1wh3RJZdHdHd9IlL1d1oHr3PPX2x3G4
 /lYlffLOIXjkuDzgLKFi7dCN+YuUSSgHZco6AkTh7S/7up6hhMZpsV+ENsJdlScsZ2ZHM/7cUQQ
 1jWOvRmpsStpl+kK8YrXpeeVU/v6/yQWY3DDSMzg0qgJP0fbD/nXKfDplRA==
X-Gm-Gg: AfdE7clQin66Qoh4mJnlxE2cLvGB2enUi6M9TlsoyAi4r3iYPJ26ecZpH95B1h1qvPl
 Y0RqzsZS7fMKKivgHku066TcJn23Aeg3XjyPXd0GN0nMdgXQAi74p6ST+ScNb3Q905pyVjcnisk
 aq+NYEdrlhLQJkLQTrOoDOXw4sIiZ9U+tONjj9LWOuCBSGe2SaybCoYyd+tGrbaaeQd3kwFDCV0
 mX6wLa7q/g/tEbwP8vu/tw5m+ci21IKaAp0VtYO7tCjz2Q/M87NUAPeonOs/geKLrkt5gvBG+H1
 +csoshrr1yKaYwGBjxf0Hc7H3rH89Vy/cW4USKpt4vJblKcjTR/4O+TJ3AxQybJhJeYf/ryIAOn
 +CsNbUHjCe0gv5jmcHpExB9izgkKlhyKphaKXEQ9WaEw5UxYIfiblRp0bH0qEn3Pioa19/iIK6n
 hGxaA=
X-Received: by 2002:a05:7300:6d2c:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-30c0701f009mr11800686eec.8.1782145129585; 
 Mon, 22 Jun 2026 09:18:49 -0700 (PDT)
X-Received: by 2002:a05:7300:6d2c:b0:304:ab8:f899 with SMTP id
 5a478bee46e88-30c0701f009mr11800638eec.8.1782145129086; 
 Mon, 22 Jun 2026 09:18:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c52daf89dsm645984eec.31.2026.06.22.09.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 09:18:48 -0700 (PDT)
Message-ID: <c556f3af-2281-465e-9b54-3bae723850c8@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:18:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/1] contrib/plugins: add a minimal dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
 <20260619045404.820960-1-functioner@sjtu.edu.cn>
 <ef66ef33-22fc-495b-ab2b-dd4db88c3d8c@oss.qualcomm.com>
 <92e1f282-2044-43bc-bf83-f172ed019af3@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <92e1f282-2044-43bc-bf83-f172ed019af3@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfX5NAIeOKAGaVS
 /GCuEle8mN87JCy+vLBxel8E5i4qB3t47nTkd3efGSlqBOi8NPsShnd2sznTTCfKNjuhu3913z+
 u9piQaR7v14/UIlcQQgShXHrJTMPawg=
X-Proofpoint-ORIG-GUID: UvrUcxrlmFmNkRWoK63Mo-J5FUaiWopz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfX1wQYUo9ic31C
 6DtccqdrZk3aa5UyP2Tq419fLUryNPY4ciqnpwfGazyXNnVD2VvyehI3Ka4CByN2zTiP4lnONSt
 qqvHJ6yfNGxJmdMylF50X37eVPHgW8TqWRMUsqpg+zgjhlpTOd6bcty7w98ruSl5YNWT70hOY1m
 lSdVpYDZAJ9oXgyGF3QQVrJWgHoL/0/Klx5qxcuDRU0p9/NYy3HFhgUDlhQ62jVSq/7vjubvbq4
 U8qo/vXiveqb4/abYbnBMJqNftjLY31X2b3hHTgqJ0HXPPplRvQmAGkUwTJh8rFYA0O1vNopnNh
 7mz99TrsNJe8hera87DXjbvmr0k1605N0qSy8CK4X+buc5ogwbIJF+hO+QIqvOCgZ0a6vjfKqld
 KMO+PjhDHDgl/+UrrHjFr+EFy0nsXk3BHo4iIcFLbm0+7gvkM2hlqSK2IFWwbjHKj5HiBFG7gpY
 DUQ4+ak+0hm7hREsaOQ==
X-Proofpoint-GUID: UvrUcxrlmFmNkRWoK63Mo-J5FUaiWopz
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a39606a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=Jgy5DngZKV4YicOefRkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220160
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

On 6/20/2026 2:30 AM, Ziyang Zhang wrote:
> Hi Pierrick,
> 
> On Fri, 19 Jun 2026 09:44:37 -0700, Pierrick Bouvier wrote:
>>
>> Makes sense, thanks for your answer.
>>
> 
> Thanks, glad it makes sense.
> 
> While I'm here, a question about a convention I noticed: most of the
> QEMU code that loads external modules goes through GModule
> (g_module_open() / g_module_symbol()) rather than the libdl functions
> directly. Is there a specific reason for preferring GModule?
>

Mostly for portabilty reasons I would say, since Windows does not expose
this. Not sure if MacOS/BDSs have their own quirks compared to Linux also.

> https://github.com/qemu/qemu/
> blob/3b50303f9563a42538a1fd5c0ea7f952e23016e1/plugins/loader.c#L190
> 
> https://github.com/qemu/qemu/
> blob/3b50303f9563a42538a1fd5c0ea7f952e23016e1/util/module.c#L171
> 
> In the plugin I used dlopen()/dlsym() directly, because their interface
> is more standard and more flexible for this use case. For example,
> g_module_open() does not expose RTLD_DEFAULT, which I rely on. And since
> recent glibc (2.34+) folds libdl into libc, no explicit -ldl is needed,
> so simply adding the file to meson.build builds cleanly.
>

Windows does not have a semantic like RTLD_DEFAULT, since all symbols
are solved from a specific library (import are symbol name + dll name),
and not globally, like on Linux.

> Does using libdl directly in a plugin violate any convention I should be
> aware of? If GModule is preferred for portability or some other reason,
> I'm happy to switch where feasible.
>

As long as it compiles on all platforms, I don't mind too much if it's
written this way, since ultimately, it's a plugin written only for
linux-user. We could deactivate it conditionally in meson.build if no
linux-user target is built.

> Thanks,
> Ziyang Zhang
> 


