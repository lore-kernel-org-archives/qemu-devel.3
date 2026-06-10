Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282F3CD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXOXN-00050l-SI; Wed, 10 Jun 2026 15:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOXL-00050G-W5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:24:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wXOXK-0003Mt-9L
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 15:24:27 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AJJVR92557622
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rUq8JBjTGtqtPM9HxuUcZeW0Q9ERp/vdUGtUVRFZ/4A=; b=dspJ3tKPmNJAmG8H
 S/1Nwu2POez2+jwSbdEnrqU+J+dkovUHFZZkJab9pQ0uj6Xch/ZCdLqBQCb5a4pk
 uiN5+tTM+Woa45Ry/oDJuNyqFVFDTFGgU7Z/UUAuxJmmoSQsYOQ0+lw+XLaq9eEq
 amEt4FJx5Sq4/aBcxAeXMtXm8eJyhyfE65r6dZu4Xh1DsxUeY+kL3n3U4LhDsI0J
 8D0U0x7p7v3HQLJGRx2oj5IV6Ccnyoa+aSyNQjdg1cUm887ZyRM5aZhjQzJyb6C4
 YnB9t7JgYBvIf24eaTnzP+zQjKQBrnkFu7M6fIKwAx9mxPs6ZPNHhJGd65YRNanC
 mvkmlg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq4w1thv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 19:24:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304f23c55b2so7593089eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 12:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781119464; x=1781724264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUq8JBjTGtqtPM9HxuUcZeW0Q9ERp/vdUGtUVRFZ/4A=;
 b=GLXLmAT6GT90eV01xwNjoyhuhVKKtvQeb2edG4/irGPsL2qSWW/ONmS/77Hhe0wyim
 PY7GH5TXpQPzm/0mnmFlxNd8z6qJ7ZzIz+etBoLzKXJRUptNs8oDQGIq8uU+d5YVno5n
 6qFHhZiIO24AxJ5qN4C9M9yvqbCImgtV5emzWOT1GnCD+eYgnLoZ3xy3AIKkk4uaQVch
 vyafCejaGPcl6gN87VjKgZTKoI8LfAkArpOy1rhwm+FvTpC4SIcBcoU7jiuG3MTbtsC9
 uGGdHtdkfwxSMlAmIw4ebq0GMGiVwdqQjw0OfgFTM9BUuB0lYNoLjYnnoplb5HtKmqWo
 fsFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781119464; x=1781724264;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUq8JBjTGtqtPM9HxuUcZeW0Q9ERp/vdUGtUVRFZ/4A=;
 b=ZnS3ONx/iBT/7yeACLUsGtOJotx6oUnoAQqz6EVylgmeExZyEmfJypq5B1gfO8ajoC
 Wxnr4dI+jgvaA5TPKZ+ytClmBRx7Qgn848UyEe4k8bVDn9qXl2ohlQ+tcF3Oo/u/IP9a
 tEVKhBdGpTApy97OazKJxsYacbK4MWNwKk7AbJcaIS0MazQ/YFGbqfmbYpugLXYbh1oA
 AIDoCZPo2ttwVYSYz9FWbBy396f9WWZaPBv+DU7mb66BevEbKzwUhnfJkmGrk0t3nrcj
 1zdBdGHHVRKnlz9JM/GfBln5eayrQm54//BhJQJjEuFS5TbB0MUzRUGiSS66WvhRHba3
 DWFg==
X-Gm-Message-State: AOJu0YzsG984t0JEz04T7QtcczZm0icZA+KoF/idsrZvkAXc4tU81xS9
 eodJlUIUMXyfrA0DlHvuEOgM63JBKUeMgjWRZP/ikTQJV80x7faz4xNnA5ftXyErOz5voZF8YDD
 HP6sDdyRfTn60O96lmyO7LYuUrAU9ShBzz80rpgMNwsG74p7FXEwks5pN2U5RgOYXznzJ
X-Gm-Gg: Acq92OG4x7JWrvVf2WEh7qELtmG6aeiPyadFZ1EH3ZhsTQvUd/QWzNJZIRRUtXmQY2M
 1agHBDCmg/rB3liADsnYVxYxMH5FKzKRrdM0UzWw/6DTz++XgU8Qqx85nJjzRGUMn71vYH2lfQu
 kbtVvZ0amq69Rbk9YF0cU0C9vYMm3G0e6RMxaDbd3LAA0fIh1hj6Lw+7ou2Pwl9mgHRcn24Zccn
 DEAcbGXdVUjdiRQw4EExjts6MhL/1iU7ls8QdDYujv2rjf70yVt7hC5MpAE68Uha3w6JerrtJfS
 OwFhR/Wc3Zv/vhpMp3dmAMIXEb7ZsulKTx3GDjjNryfYgEmlblYKMjr4VUTkHE9WwhuHBVJ5SLQ
 QlB2j1avZSQGcNRQo8qq2q7WDhw1Ml7ICpa4DLCSS0Ec5l6XBX2KedW2mzzYvK6/7e40r1J54L0
 iofJQqdx1kIrEMqqx1nMdo8VUt
X-Received: by 2002:a05:7300:d517:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-3077b866467mr18663620eec.34.1781119464122; 
 Wed, 10 Jun 2026 12:24:24 -0700 (PDT)
X-Received: by 2002:a05:7300:d517:b0:304:de94:1c2c with SMTP id
 5a478bee46e88-3077b866467mr18663584eec.34.1781119463464; 
 Wed, 10 Jun 2026 12:24:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df191d0sm38912276eec.21.2026.06.10.12.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 12:24:22 -0700 (PDT)
Message-ID: <fda23ed0-da37-4aed-a00c-4468d2c8bdac@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 12:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] gests: update ubuntu2204 to ubuntu2404
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LT4XEvxiplymu8yUhW8EAR9bHxUvvvJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE4MyBTYWx0ZWRfX4Q9rIWBBsbdi
 9KldIYFmDPymnYUk20MJNLe/xryNOdSBiKNtSNWHsEM41zYAbBH7cR0WjyQR8QdFaYL2fccB8KQ
 KpaIVMRnIj5wh7n1Y6jJhrIpkGh8Z+/EvACKJuQX1dZ/V8geMVskWJ4gwcqrum0J/ES8W5kcxIA
 ObEY3m8NdJdEYIfF/JaXAlR2/X6UREN6YKrPSDfIgk4dJ/785pACR2yZ3Hq3mjprGmTJmi66djc
 INLFrLfT0eUSOUa10AT02RO0N5YVvmIqM2EYOWFANjUmwLJKfrAGfib5zXCSb1WBGeTIkKSamSy
 sVvEG5WgFAG5QveuZjm4wFWLD50KBmVdZ/ultwSjawCnYUF+vLdNEIaZ2JzOUw/4sVjf64Sl6cm
 WIUseavMdE9Q7mxRzmOHv7IBvsJ0D6PRCfU5SipyJBE2chSyADnAiwt3iZQRaeOITl8ysdAYX5k
 AgbQdBjyYP38m71IG6Q==
X-Proofpoint-GUID: LT4XEvxiplymu8yUhW8EAR9bHxUvvvJg
X-Authority-Analysis: v=2.4 cv=ZfEt8MVA c=1 sm=1 tr=0 ts=6a29b9e8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mkg-ff_Mvfj7XMvBLCUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/4/2026 2:51 PM, Pierrick Bouvier wrote:
> Ubuntu 26.04 LTS is now available since April 2026.
> If I followed correctly, we support latest two LTS releases, so we should be
> able to update. If not, feel free to correct me :).
> 
> Pierrick Bouvier (5):
>   net/af-xdp.c: maybe-uninitialized warning with gcov build on
>     ubuntu2404
>   tests: add ubuntu 2404
>   docs: update mention to ubuntu2204
>   ci: update to ubuntu2404
>   tests: remove ubuntu2204 container
> 
>  .gitlab-ci.d/buildtest.yml                       | 16 ++++++++--------
>  .gitlab-ci.d/containers.yml                      |  6 +++---
>  docs/devel/testing/main.rst                      |  4 ++--
>  net/af-xdp.c                                     |  2 +-
>  .../{ubuntu2204.docker => ubuntu2404.docker}     | 12 ++++++++----
>  tests/lcitool/refresh                            |  8 +++-----
>  6 files changed, 25 insertions(+), 23 deletions(-)
>  rename tests/docker/dockerfiles/{ubuntu2204.docker => ubuntu2404.docker} (95%)
> 

sent v2:
https://lore.kernel.org/qemu-devel/20260610192222.2709135-3-pierrick.bouvier@oss.qualcomm.com/T/#

