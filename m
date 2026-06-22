Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F50BCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbj0v-00082Z-Lm; Mon, 22 Jun 2026 14:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbj0u-00082C-9F
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:04:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbj0r-0007E6-Td
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 14:04:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVkvS2691562
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 18:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hfhoECYTGllKYv6GH8/89Tj5tH/lHsm7OczJyduzOQ4=; b=oqIiXCWJZCz2kVgI
 8BBOD7CyCDfFFyWcNoIzH/lGP5Vw1a/LNDtnwdlnQ0XVjfvz+/EllgGcM8juca44
 pPTCsT5vgw3AOlfAbDzDB1Nr2JAO74P9OGk8VWRQCc6yosEoeJ9laKGiO5XW2uKE
 1rercbgrLFyUhRVeKQe/mC6MMLKgRVaZqh2oVlFManrWrSXI8qGDZsjOfzYiBD19
 nuSI8nZZmPqUE76x+Fljp2JxzVCB/Qrp3wypgCvoVa8WNA4GzeZ9PkIsZ40E+WPp
 hViHwhrHWNrXe31Iapjo7DMv1Ba9OXO0J4v+UZqZDUpnkeiL5pq4sXq7OvSDfaef
 KuZoOg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn13df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 18:04:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bfe262ef0so120718eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782151487; x=1782756287; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hfhoECYTGllKYv6GH8/89Tj5tH/lHsm7OczJyduzOQ4=;
 b=CNA1EGv+ic1eC2Z2qdn89YAmq0Bs/uipp6oDoOPQVnIXvNutnHofdIBHPllmLdhce+
 hBeOxovtrSvffMPkWLm0P2MvkKUVZDSatL61nbSNyXxtXtTTbLzOQkpmfCXc5AmeHQIu
 8frg8hOFFFhpgza2ynVznc3zHY9uWEXiJxDAPMF65cNiFYvFHCXQKdRm30+ZB0eIJ/IS
 E7uN9z0EpveU1AQPOBWdhbPwsxH0XxwlzStOI/pBAnYxdUNo7J208Pyn+F0VgvZN9H95
 paodEysSuzri5lYqGVlhQKcqYmAyQh4t7/DaZOqbsYTpgKCkuTxowMfOfWUVpN9tx9Iu
 HdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782151487; x=1782756287;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hfhoECYTGllKYv6GH8/89Tj5tH/lHsm7OczJyduzOQ4=;
 b=UKcbGWN0ngfwh5b5qBoWfdYCbI7COVbM8mVvhhgp4hX1OfUtWsZQmvODX7TKE+MBxX
 C8TSlh2K543wCDJfjzGymQUfQfODha07ix32cQ48ufdzEHfRXWjI87Erysr/u1lZXzit
 fIzrrSaJkzFKAjQXIlwEiteFJQENO93fsK9NXIGJn1NKrd7n6arejdpxeySmK3L9d0e5
 S6JqfzJ17gOjLeSPTMQ9HKqxiK2Ua4vt8M/I3DxnYoVnkzakQAWcDowvHLWZapGFf/In
 4TCcwP7bQZQbPce6fmM18yob4w5EsiEtRpGXffcUJGyfjkGS063JqLzNAQDGcaOR5kB6
 /wWg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rol/vnMP5GFg26/zS371xwtC8BmkU7t94e0hKjM8jufaW087LvhouFcSwCowHiywkoUX/g+FAt4bwih@nongnu.org
X-Gm-Message-State: AOJu0YwPZ+GZSLNG1DDEK3KXX2sHQWniG8NGxFdbdZS4nva9DIe72zwT
 0ABv30cKXCpbZc743+7nQeEF4U2JxMZXpXXCeV6ARLE/CbER/tgablgQPUlyuFtKuCQIzULFmS7
 YNN3oYzl1+/kDmU8v0/JF7ClJLQg4n6ovaUsXFgY3yyjOk2B5sI6h7Lg/SA==
X-Gm-Gg: AfdE7cnCOlDi4P08tW+Azbo8oV41xzwAXXii6pXpI/LKjHjyi0NbGzMjpHFGRNDxQb0
 wsKDVX4FK4KudBeuOUKk5tKaamuSkgcMmWdDqo9XXmwShR8i4YZLkg5TpFgfEOsN6wc+Zrzk++r
 jyA27mxbOuW0mio2/kPnps5+uzB1NHBFWJRpIIna3gmAa3wBtCXXqLueX+jqSSOgJNFfLBJsoAq
 R/LvnPeRRE/mFUeHM+6NREcaNAhurRbLndRMzT9WoTtiEcDRRE7oXXg3jtlCHq73IzIXYEwt5AX
 b8MNQM1Jf2eoicY9vyLxj01UQIhLsxG6UXeyd32LQrX3wEW9cR7pfjYRAE0xTCT6XqcviBMhOj1
 zVhRAd7JDKJX/XcXUz2Wq71dcvLTzYUr691RCqb4G3OWo+cNdkwIeBnYd+bo19J+emg1qzUn7SC
 NGxOg=
X-Received: by 2002:a05:7300:1801:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-30c5556303cmr432647eec.8.1782151486676; 
 Mon, 22 Jun 2026 11:04:46 -0700 (PDT)
X-Received: by 2002:a05:7300:1801:b0:2ed:a58c:942 with SMTP id
 5a478bee46e88-30c5556303cmr432611eec.8.1782151486074; 
 Mon, 22 Jun 2026 11:04:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c5178a68dsm1148912eec.22.2026.06.22.11.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 11:04:45 -0700 (PDT)
Message-ID: <9cbeb740-405d-4738-90cc-fce7eca7d9ec@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 11:04:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
 <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LfUGXJnmm5cWgl-fAreobqQrvcVA9Vot
X-Proofpoint-ORIG-GUID: LfUGXJnmm5cWgl-fAreobqQrvcVA9Vot
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39793f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=ZaQgKWfZJN5dIZQ0-FIA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE3NiBTYWx0ZWRfX3515L4ugVOog
 L3SuSRPI1L+nzKUz67qiXj4Q9OHTQu6VayuMQbF/f2A4lTvRlNlvndP+p9HoUwOYUsUTdjs064G
 p3BBsYCFhpL0dGDYhD/ZLM1IX0ES64M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE3NiBTYWx0ZWRfX/KxciVJmWvxf
 GbC1YaCDvTRDEmJ5Lo2YaerhFxrBpOShJnsTlX9c8NK4aJK+HYNilh0zmYgF3souy9kaZgIHbtw
 Wf3nTU2zUj4ZJ0H/8tR6RccbW7GGQGQObMsLJKOJnUpTlrLFpal7qL/cNpwEDMuQBYcAFZUYx1p
 bDt+/AVvmivJcyYvxSuWTOZsgtbL8SA9hms84oyzBxcJ5G67YW+ecLSS490wHmU6m6kXT1FWh0E
 +LdNfHLEhmevUfqJkpYGIbg/WRyMluY9a3txYXya/iBRM9HBqoeqqdr2AtV3yr56NIe5I/Jvj4E
 3qS28XOKlHq4q5R00mjpYPvLdfCc0ifjAIfb4IntNQdHAXyIMEPg2CyB2YJnRQnBUyUKmwo8rsS
 8BfFX/fqDxwBS5DMwEnyHQWksM5T7JKHEv8gp8RszaKN20PcYWmipB9/Wlq5z+jD2PY5oyOHgoa
 zAFaHQIVe/bVIWaqQKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220176
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

On 6/22/2026 10:50 AM, Ziyang Zhang wrote:
> On Mon, 22 Jun 2026 10:16:29 -0700, Pierrick Bouvier wrote:
>> Thanks for the update.
>>
>> At this stage, even though the plugin in itself looks good, it's not
>> something we can really merge in, as it's relying on external behavior
>> that is not specified or being a standalone tool.
>>
>> For instance, if we have a public Lorelei toolchain that implements this
>> for libraries, it would definitely have it's place upstream IMHO.
>>
>> Also, the same kind of contribution can be done for other
>> instrumentation frameworks, so we can end up having a single interface
>> (and set of libraries) shared among all of them.
>>
>> What do you think?
>>
> 
> Hi Pierrick,
> 
> That makes sense.
> 
> A few thoughts in response:
> 
> The Lorelei toolchain already exists, but it will take me a little time
> to migrate it onto this minimal plugin interface, since the ABI changed
> somewhat over the course of the RFC.
>

That's my point. As long as Lorelei is not a stable tool, we can't
really integrate the current plugin upstream. However, it's great that
you posted this as a RFC, as it shows the approach work.

> I think Lorelei is better kept as a standalone repository: the thunk
> libraries and the guest/host runtimes clearly do not belong in the QEMU
> tree.
>

Agree on that part.

> Since the plugin only defines the dlcall interface and says nothing
> about how thunking is implemented, the Lorelei repo is just one
> reference implementation of that side; a user is free to build their
> own, with any toolchain or for any framework.
> 
> So, to make sure I take the right next step: would you like me to make
> the Lorelei repository public, with CI that demonstrates the automatic
> thunk generation? And should Lorelei be referenced from the plugin's
> comments as a reference implementation?
>

For now, I think the current plugin should stay downstream, until
Lorelei is officially published and people can take any library and
compile it with it. Once we have this, it's easy to motivate integrating
this plugin upstream, as people can do everything themselves.

> Regards,
> Ziyang
> 


