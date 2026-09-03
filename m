Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF8AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24a1-0006LO-1x; Thu, 03 Sep 2026 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24Zz-0006LF-RH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:21:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24Zx-00026s-FN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:21:59 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH7NC1328101
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p4AyQZoGVy0zM0RRfLhidraXbvp6im0WK3puGATXWVQ=; b=cz2hpJvU9THIIXZI
 w5+JZmfhIaRfstcOsdR16i68QyEKLDKV20yy45+jTkzltObKL4l0bNToIP8q+mYv
 vMzQdRWNKlv4izLOwSX/vfOVqne5yZ6rB8y9c050KYd/DF0KPA7bEz1pSSvCZvEm
 g9MPCIpVsPZ23YOkjcgi8osoQsphI4co3dPRT+aC7YkfjdIJtyQoaC4g630nlPKJ
 NgoxsYRf/GriPha5IIi34lOYHd/2uGt1AhhbAyzApvE3RF1Ax8bvRuGNKO2CXpbM
 XZ5s2lwqJAw2DWGegNdEkW8z5SZgeK/awp3U99ov/aFytUAZUpYrNTaSJIWmG/pt
 IXNVRg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmj2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:21:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9382f9430deso408171385a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788430913; x=1789035713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=p4AyQZoGVy0zM0RRfLhidraXbvp6im0WK3puGATXWVQ=;
 b=FrSoueE9x8krwfECz+kx9Zi6Dm4Ecx1rNIesWVvwM/AMrK1znPdQC03cm9YKkvxuMi
 IDYq1dgYB5V/j4YZTBM5+oMk5xDM4BegyvVR6wj6wm80KtC8J2L3xpXlGZHUTni/gNzk
 PUBiIBB2RD6hfTDO46OiM5YNS0jJ/wwEUtVBHfXQ1gyVAd+TZ0TK1TT2znzK1/cYhpLN
 MNt+Ltn0zotJ67Lbv2+tcSV43UrfddoxLJkxNnH6RTbLntwqpYFd7Gw6vsTB3kiiz7w+
 lww3nkexBFhjTVase0qjqqHY8PRtgSe6Wd8i7qbjXxs2iDpJaAhggRf2AG/Xz4H2d8qV
 N3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788430913; x=1789035713;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p4AyQZoGVy0zM0RRfLhidraXbvp6im0WK3puGATXWVQ=;
 b=UCr3JbyORD/8SgDoFS82Pw9qJ+Z8pY+UD2XeNaEqQtYI7/chrMC9xqaWXouwXG0bVe
 h8fpmFfIjD03ZIWXXQTUusm5G9dxHM6u4aTmxONGxQg5zAdWoANadTbAY9igFO1FuaXn
 VeY6Fr0j8b2JbHsjMHHVwdRGzLRqWKeIHxklVHLJ6PZvC31xGhj2nHTxCoYCzKz9o6vv
 d/pdVXNFnrqeF28W8tQVNHOPkyeSwZo2OVZeG/kHrAaajIcU3owxJQDaEYznMHJNlcvX
 YqYgJgG3EkcJuD4fGBP5AI1y3GbYLfmO072RIymNS+4bGPpnPa5QIbYJ2FW7W4WRyMC4
 ElGQ==
X-Gm-Message-State: AFuF++liDWJ78B3MOgzf5oXOwo/LjJUUs4r2g7vvbQuRHc3nb1fo75GE
 Onrth/cQbHiT/ccTKgt5XXVLZIUzrVNzXQAYM/+U7v05NUobHOBPONY8dnvecP0QUsv4eTsCjgK
 40s1Hy24eqGzC1qduHPPyP8naMHRnwZ6+IBg5418OIZe+plIbzEDuTgmO4Z3Xp63KtA==
X-Gm-Gg: AYBFou3q8ygbg0fo/wi6kCLhqBl14jvPnv+derSNGgbcAwF4VkrmGuSZ1HD6BuJK1Ln
 176d0SdbUFV43fDnt6N8bbDvnS86d82/H1TKTv5fGUwV55jqiMGwCq2vMipv399FJVLW9uXAKFJ
 5ew44GwDxzEvno4olP+Iu3Iope2DKsJbVRllPcSs70/wYEfWwZQr0JpljoesohpxoFS69S+4wg6
 4vqMJBjnZBFWnRIyuGZl3/tMgvAfq5qyC/rqKXuqIiU0MHyU1lWybUUDzg+Sde94D/NyRmrnCsP
 NIFZLmURZv351ePRp9h3mr3wjpDE2+vWf9zfQEcY51yVucchp3OvBU/G0fHTEKbomAJOdZrSiQz
 nlWvO7MhZ8+saqO6hrgYqnYb1ahhPnVZ1Yg==
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id
 af79cd13be357-93960ccd7b1mr1341094885a.8.1788430913454; 
 Thu, 03 Sep 2026 03:21:53 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:939:2bbb:b266 with SMTP id
 af79cd13be357-93960ccd7b1mr1341091985a.8.1788430913040; 
 Thu, 03 Sep 2026 03:21:53 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf2531232sm34661735e9.7.2026.09.03.03.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:21:52 -0700 (PDT)
Message-ID: <b0d86e75-4b87-4e7e-9c85-2957fd519153@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Stop reviewing meson-related patches
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260902155105.32165-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260902155105.32165-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: n8L8tqcKy8KBK4eqFsCtXwAmvhwhd7un
X-Proofpoint-ORIG-GUID: n8L8tqcKy8KBK4eqFsCtXwAmvhwhd7un
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a994a42 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=S56xvJB5AAAA:8 a=EUspDBNiAAAA:8 a=2WPgOG2EWknFsmhYPfgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=MH9Ivq0PDQRhlrFuIVvX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX1zq7N8sIFFaY
 o0klCdbffxFkLkXAH+iOEYkt8eiNqFhFdbQ6B5gzfJ7X8xNQYtqHgMZT9TDosFtQ55bWa37JDw1
 VmdGeJ0sg3u9+b53f36LNnHGHNXeDW7As9T83bQn54N9PJmG6kvUdyTVkRJdQFwo9pUfDyMrQtT
 22035Xrwd5SL/4fpuLpJiAvw8q3rtZPyZ9hLyGsDRL+bApxdKWq4NL5hvKvpH62v3p9DWhmZA7b
 QCdw5dJrai6b+lYMmF7YnFDDtTM8LTCSv46pEG6qWN+ixSB9+SQ4KzjKt/P8ruoVZTo9EMiCOJz
 dyAksuWEhYy8hO7q4Ug6UFMnnZoyYssPIQumDBW4+Zgn2d2D2zV+j5jvp0Qg5I9Sdg9WdUdj4Ub
 AdUgSxeVeKUQPZTOysq0eod7mSe6iv4xNvcaCyTj6ACGgpdf4GsGjXtX4RKE0Y0WXYF3I1T8BFf
 Qi+5fxaO09i05QIztRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX2MrbxyxYZ6+8
 nu1C6ggy80os/alzKCj1mGt2vVyTa3d62iM6tNIfr+jYkpk6lc+Gz/f5im0iAVs1ceaWlOFyZhf
 2YJ8DMs7XdUCBDLbwLgVQPHU1YbGTo4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030089
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

On 2/9/26 17:51, Philippe Mathieu-DaudÃ© wrote:
> From: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> With retrospective to commit 48fad83ff49 ("MAINTAINERS: add
> entries for the key build bits") I think I only wanted to be
> listed in the "Top Level Makefile and configure", not the
> meson one (I'm not following meson changes closely enough).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
Patch queued, thanks.

