Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2C606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I1QKDI2f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SqEI6iZn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP4nC-0004g8-J8; Thu, 05 Nov 2026 16:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP4n3-0004fe-Tc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 16:14:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xP4n1-0003gN-Ai
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 16:14:33 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5L6Omw2529113
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 21:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 U89MapWW2reAEG32VxupmTwR3OlW8uSj6LB1sAv+08o=; b=I1QKDI2fDLp4Cgk/
 J9M7CQvEC2hBcgjKPz0mFWu7xb/QlhxvE5mwoMThm/SiLo7WA9FQ7ZHHbqxpTcdY
 bxbFE3mY2xoH4bS/kv0YSLAEXzXprXDoQDyTesT8ziyyFgKx+tOkXjgioE8NGFwr
 ZZ0eDjomoID71F+lVHAc/mJU5i+psVsS2CE40hhji+NODpCsmZUeGpRKVTVeoHWz
 O8Py1bGE8165Wb3zDfQZ77TzEkaQx1xC3iSKVkrxfMHk7trUivCJxu/hAAXOzypE
 300/0yuZbq3Xx0I2+gOsNewsZDOfEUwocVx1dGpGIEQcSsYmd0GokS629XwnDHE9
 1hGhvw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hryw18fuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 21:14:29 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36d1353fdcdso1515085eec.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793913269; x=1794518069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U89MapWW2reAEG32VxupmTwR3OlW8uSj6LB1sAv+08o=;
 b=SqEI6iZncVHkSxLvY6JN9NE/XwFXBwT6ccKMPhCpHlypwYkk4xzvR5ao+8MO+Rao9P
 kzrQ8p4Ki+9h8DR39yuGOhGdQDdEPH3fPDD/BmHbI5Y+y0QhJhuPrKpQOKcq41adKSzT
 +CkuJR+tcPslf+QQw+3rlJCRwfqZUBpTYRReeEZ+wxw/9Q3mriy7Z8co5aNIz3hbF0yV
 0mpF/F4T4tzZKY3lL1NUTWf2+86gvyXeBcpid/RJciyDi1dGjsUdD8bLGfFZJd+icN3w
 VwCxWf1w6Na/QrvXTFL7wF+HXLHOALlRvPA6T4ib8sHATnFmtiY5QI+miCb8alv9kxFS
 uGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793913269; x=1794518069;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U89MapWW2reAEG32VxupmTwR3OlW8uSj6LB1sAv+08o=;
 b=XqwLFFGejOCNJqzrU++c/80cMQ77OP04Ji79XZ+bx9iIs4sgHUapChx0j4BRqSTger
 MXxtsOz+De1EB370IYXl1mvvwoq1mGWvBOFZ/g93hLr1g8TaoZYeNzYfPdI9auxS1Sgl
 A0R62PUfgzjzlw65c7rA/PUmcmnfDrtgAGNKtRIcsjHLZ0NbTFP+h3YH9NgH8WxIL/qf
 PEgN4NkdR6ft64WcQqes/+09p3oZzo2FgkkLwj0r3E1qM1EIqbzqwizg0hrL/QQLw0Z4
 5bTvbickDZnXmRwDvpnznMYqnvmD2XEIxpAEr6+cPJh1MMBTzKlq4wf4rJaWsEPPO5Br
 5rfA==
X-Forwarded-Encrypted: i=1;
 AKwUvByzDFbTDqXn5NgWZGkHoQhJCQ6BM+T/oZ8M0R/wlw01rC4OMesbfoXtn52DuG2Ib+Nf8n+3Zo6DsJi9@nongnu.org
X-Gm-Message-State: APuU4Z87z+2wwJ+U1mMHLF22jbb/oIwEmEIV6A9yQff+iG7e5WHjrmO9
 9e1FCIOuzDZjNVUUM6/c+TmmP416e7ROcljrZ1xDyiy8GO0HTP66EUeoN22gRAbq77p1cTYCIGq
 YzJwvYfRe9xZM0LJIfXx6b27JvafyYeEOksfDsLrB0T90ZC1jX6LhHSL+Bg==
X-Gm-Gg: AYBFou3U2dpSHI58xhiQK2afZlQGXoE61nC4USOjt+O/IGjxB2IYFY8SaNv35BQIYDN
 X7FNxkFSlNCW9Q4dW1KqXBzwWtf3REBs9dp4bounOUwzfv3WebRGlT9Dqic6qDCoLSn2M26MG0h
 OBLouXBrgUnvZ79wjB43EMqzwZL4B5wMVKopCzUc976rHmAo4eASnDjQPIMv0bhJ42aopKzPXiy
 SwKqjTpBMGbOvkiqcs0nUbEznzlbM6fcX0SM8mCGpKFga/PwnsO4JmCPoZqRZHIZOq/xjRGp5n4
 hQnaQHy5RmUV3czfvxgqNVGCXuAVj8hqWyg+i4+Hb8/Sxv9l3W/qwQfqqEHDMeObjI+cJTQWSKf
 72Q2Re0izM5O0+/s98ujqdogeEYe1BnoSOn/j/mvEJxKpty+LI8cJTviuzpy3idOiSe6iqDHTWV
 rVmNHQQzkuI6sFMkO/O2SP3k1+vCc5pxmjIV3q/iK1aQ==
X-Received: by 2002:a05:7300:8281:b0:369:f2f4:b227 with SMTP id
 5a478bee46e88-36f75b1ffd2mr466443eec.18.1793913268453; 
 Thu, 05 Nov 2026 13:14:28 -0800 (PST)
X-Received: by 2002:a05:7300:8281:b0:369:f2f4:b227 with SMTP id
 5a478bee46e88-36f75b1ffd2mr466364eec.18.1793913267178; 
 Thu, 05 Nov 2026 13:14:27 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f71a25c1asm1665480eec.27.2026.11.05.13.14.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 13:14:26 -0800 (PST)
Message-ID: <511c5849-5493-4a38-a710-f4f4f6e18137@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 13:14:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pierrick is maintaining the AWS GitLab runners
To: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <CAJSP0QXzingvqA1F2q-QH9GvtMz7YpxDK9RsDEF5JMCE6vA+Hg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAJSP0QXzingvqA1F2q-QH9GvtMz7YpxDK9RsDEF5JMCE6vA+Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eME1pGBNCc6PB1hSqC4a7LTGV3Tvdl9K
X-Proofpoint-GUID: eME1pGBNCc6PB1hSqC4a7LTGV3Tvdl9K
X-Authority-Analysis: v=2.4 cv=RdYFmFtv c=1 sm=1 tr=0 ts=6aecf1b5 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=ID6ng7r3AAAA:8 a=2FVsxPHEEXSffYjUPhIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=scEy_gLbYbu1JhEsrz4S:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfXwrdlSD5bl0S0
 o3eWyCw88jfY6FJ+VnzkfSVOfvPR5yJEXFmbxYElneTV+7CwqOROxcrZvmm2KZQ7m20NiBD57mk
 u19SCCaInLUBY+293Wd6JvVKJuDOjt8ANntxgmixWW6FNHkQjrPiqh9ARq9PLFtTMeg/n30aeI3
 EYk/YzfpdUyAwK21alj3PCteGfxy70Zs6fLg+fohEaDgQh9WPstCH9XxO6QkbXMoQSbbEXsPRzp
 CN1is+/OC4zdNPVZYun5xk4xmj9ZgBQwJ3f2JCqzjMkzQjPTQv4+aUxnEJH4NbP02O2JLA3zElG
 DZhkEbr6+43ZnXq6vQrKXOHYEBhHOkMtDGCeIfwLt4Xmtmxwd4pdI8RLfBjD1Cg2GhFzkps9/vo
 sicS7mDX2KvT50TX0L5mfHiwLo1Xliwhjb+OWaQogCK4p7/QJdghWKKBimoyDfz36tIVZqrJcfX
 rLlJj5soo8fZYPVN8Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4NCBTYWx0ZWRfXydL/Hh0WS6E7
 bNWo2Bs7v5IA2yatwY2Q4zjs0GSTHnPx+b7a0ALeOZWBrNX8Ng+l/yafb3ylpROecYmsZLjOzsB
 dNYg7qC+omBdvKLz1f2CS2a617/LbuQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_06,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050084
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/2026 1:04 PM, Stefan Hajnoczi wrote:
> Hi,
> Pierrick has volunteered to maintain the AWS GitLab runners that
> QEMU's CI depends on for x86_64 jobs. I have given him access and
> updated https://wiki.qemu.org/AdminContacts to reflect this.
> 
> Thanks, Pierrick, for helping with this!
>

Thanks for the trust, I'll do my best to help with this right after
upcoming KVM Forum.

> I'll continue to handle the yearly Amazon sponsorship applications.
>

Great👍!

Regards,
Pierrick

