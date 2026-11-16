Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4D2606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EG1OAC8R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DFZ9e+xI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Cu-0001qW-Vb; Mon, 16 Nov 2026 16:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Cs-0001qD-SX
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:25:42 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4Cr-00017v-AR
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:25:42 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfXA2912920
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2BdzTtZFzB/ls3BpnAITkK3OyNAODXd7P9vgGnuD8ms=; b=EG1OAC8R0BtrDuWH
 U5u9A+DtlNgFmXFFQvBn7BYfCYHeL37ahJ2TDpXfAauUBVMoR6rx1eALICBd7E7P
 IPhVpCiOuI4KzwaFcwOANHGSGYrMLtyOMQAKWeR4YapvdBLs8bfz6/kqjIQWy0RJ
 uAY4g3uG6RngFPlJME7/JGEbFIqxt1PjSDVXVsqETbTT6BFjBCVtYNbmmklUyoBl
 UGVj3swDhsGmUS0/7Vc8A8yQyLTPYebUTz3JenBnQIZNHRgccrDzpqGJ2SVinMc8
 FQzy8yHipk0RO871qPd07LkvYOGQ2CTu8qchHh61Laojq+5HaYdMaItPchEZBjpN
 asMVFw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y1t1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:25:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-37628596fc9so10399946eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794864339; x=1795469139; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2BdzTtZFzB/ls3BpnAITkK3OyNAODXd7P9vgGnuD8ms=;
 b=DFZ9e+xI4dyIca7wOsbsaDxvQ4j9RhLOcgnIoEqFymh5W2I2TL+g1d6R8DK/0yK7g+
 zbLb7UbrhOpP/W99bKUTye82agCn7wuIHWp5zHSu9j6tiDBguz4M6uodeWPVElyBXgqz
 zJpv4WUzaSKOwodOIA95ONciCatLlMuswApJmugbJhtYsFEEiee4ro33OeltYO4YqQuj
 1yuLM4jpsQasUw+hDoUIhblf4nYOVATE8O55Gzu+4AQVhcDg8R3agJTfWwYWtleyWnYZ
 U6fC+RUdNos7E7LL6XLNn4bC80icJVw6wiHtm89UQnZj2IB/N2tYZwrWynkThS3mTT90
 XoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794864339; x=1795469139;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2BdzTtZFzB/ls3BpnAITkK3OyNAODXd7P9vgGnuD8ms=;
 b=1LmJRKCDf4VHJ+0tXMjq2wyC+Qw/u9LWWqvvRbAYuVbnnT+Fd76wTQsN0Ijyyasg0I
 cRqTHMeQDV0G2Xx2S1UYzc39w51a8mkdWrhvrJQKOjbc84BRymM7cc/wkuuvpgzgvPeI
 I1Mb0kcMvvEub3oTyrFo8NGJNNMfk66ecZTjVrArX15tzvtw+5LD14QLD0tQ04oB9tst
 eqKowGheNK9DmvfdOEvT9Kxx20zCF9abzs24piJC5AD+9J+jY8pKtuKQZO2iZGMZZj72
 ClzqGZtpi+W6q8IXMupYWCwxATAZEb04q9C/wcMYUPAehLCLMSQ5lE9fuq4KZdJfEeXG
 OJeQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG/A8I1/ZJgzIeDxGqC4Wo9l3k1rGTcqe5r3wsTl0smHWaZsU3OoxQEmZnRyXqbu9ISuiV3uUTinrx2@nongnu.org
X-Gm-Message-State: APuU4Z+HqZh2oT7zUuJ5ua8EUf2NuQ0Wexrb5Q5LdIvLNuklgogOgEF/
 enmiU9Tf6eORHzeHG3PS+8GL7Ne+eSdOfI6LBlpWB6Z//CWia9pGKIQyJeitTvMruDHLXWWK+54
 Ap0P2FV4mp65QvIlp+iwyIRlI1qzP/Ull7h3LcAx72nFnGtNb8DTqSzJJCw==
X-Gm-Gg: AZFdTZda7kC9ey2BhBzD+NlmwG01LweHKjNwk+n6k7HoJX06wlYcPsH4hCHmd5babpm
 hrpN50QK6Nlt//hQT8gFSaAkvfuywfpsXlRd/rfrpSFLOubAV48+6JA1K+wPuk8akqlKYxs5hXk
 1BwxjK7W+tRNp6QqVjeWmP7WeDFbdtfY2JL0xqhZIVGgaEkh7+AjhAfX8G8Cobo0N9IpGw66qTl
 7Xmn2TnKmmZMKep5wS9IGUJlRwWzPSurCfTYInAPGCTdsQGQPX0wKmMBs8z5ExQmDVGz8yoHCAy
 Cp7Hl2u3OD5anCl2PNDxWQsaeSHpi0ohQCbi9NM9J+T4MGxKvRePCB0aNRgAedxtmrPuW6i3Mti
 Gn7/cDEZaK3YeaH2piUcmuU2kOTvkaKCyX887SvSS/l3bSMgfB9418B4yrKgHnKDEl8isig8CdX
 ObhDkQa7fQwnagyHYEIMh3IoLvxquHPlC1apt1GWYqzmE=
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id
 5a478bee46e88-37967dd7e1dmr18244174eec.34.1794864338952; 
 Mon, 16 Nov 2026 13:25:38 -0800 (PST)
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id
 5a478bee46e88-37967dd7e1dmr18244140eec.34.1794864338415; 
 Mon, 16 Nov 2026 13:25:38 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm56161744eec.8.2026.11.16.13.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:25:38 -0800 (PST)
Message-ID: <87493520-d995-493d-add9-7e53fd323d99@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:25:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/48] hw/core: implement TYPE_TARGET_SPECIFIC for machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-35-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-35-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: d57JUBxmYpwKzuzVW5_x8W3BqrVhBG5-
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb74d3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=W1rROPmq9uVLF2Ejkr4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: d57JUBxmYpwKzuzVW5_x8W3BqrVhBG5-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfXy8rvD6+ErNAJ
 qRRXKdzeyF424306tuNzCnk+KqvNisk797G9o+J1j3wr+mUM5DCZZydgrhFgoc+nJUsd6+asOpH
 9hXqK8Vzf+VEd9wzamkhA32kQfe866c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NSBTYWx0ZWRfXzX6igSvwGvRe
 OpYMPdaZ0LVlTMgLN1P6LLsKaYwtO9Oo0sfUY4KnMlaKPWJyn55Cp3CxvXsvFFc+yq55ASEYOZX
 gRjQUiSLUXlsLiRglwsjETo0T2RjMXyBull5LYU/MqNXb5RnawBcgMz7XuVNZtNgR8hRr9DOgug
 jmStEijpL998Erxy3U0PFLrQSWUnS4jdeBSZ+KJIW9cdb90Hf0Tm2dLXGMraLs+0Wex6mzOrg0e
 Rnr/R+me8Wxp8dkau19ksxZBZArxrzxscQxektr/2NHWfkQC/j59yJWdVebbaFjJcJM72Wtixrr
 kBjFNUuYhuaUvvN2LYSfRwxdQtd8zUr/z/DYQVUuYy95yy1InwmpO2OcP2eiB4FJ0sYK8k4c8w1
 qWu5qO1vFgEouKR7HyqbuJgEmSrE0RI4AvjANhjquUMnbo2EwYJxjGFrj+8I1y4Fo6nuzNcCC4U
 fvJeXI7h21Fps7yZZ6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160085
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> The Machine base class implements TYPE_TARGET_SPECIFIC since
> its children will almost all be target specific.
> 
> When the 'targets' field is set to a non-zero value on a
> machine type, it will block creation of an instance of the
> machine unless the current selected target matches. This
> allows the current 'is_available' callback to be removed.
> 
> Eventually only the 'none' machine is likely to leave the
> 'targets' field set to 0, since it is universally creatable.
>

Once all machines are correctly tagged per target, maybe we could simply
forbid having 0.

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/core/machine.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index f7406537aa7..8692365ce89 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1804,6 +1804,7 @@ static const TypeInfo machine_info = {
>      .instance_finalize = machine_finalize,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_ALIASED },
> +        { TYPE_TARGET_SPECIFIC },
>          { }
>      }
>  };


