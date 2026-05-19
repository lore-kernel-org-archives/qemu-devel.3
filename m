Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D05CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPK7E-0002qF-3E; Tue, 19 May 2026 09:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wPK7B-0002q7-Sv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:04:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wPK7A-0007ES-3g
 for qemu-devel@nongnu.org; Tue, 19 May 2026 09:04:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JAeSdP867154
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Spy9t2o9wGWtNfNjhf0jiLHajNLRXFHQOMbKOPJUOSY=; b=o6sbPbq3nGyikMbh
 R5uK8Rp7gYkdzl3midcagPu00sAgl7wT3h9KVULkmayQZAEJ+Lto53/p/SHxIRph
 X7g9Ypyk6zusueEEaH01WXqt8V6Whknov0xYqCrodZxVC1QGOGFzLcL4+aODgnI+
 kjx8QVPpRpMOzgxmxa9/XvZNJW7WodrDQmqicRWtikfBpLqVm7NDAruY55+Mnu44
 QeAm9Cs6wZ9g/yRgOVpK46e5EB63OlYBH3306NuZk+ep9YAJnmYXkHLm9cmRt8ws
 cuGqvkEFeNVuUhECOfCXfdA4LYj8alxna1wzU+uVYYtebXe3Sr35Ugfat+ZW+uWV
 pACoog==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8hv1htnn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:03:59 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-65c7306e432so6367274d50.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 06:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195839; cv=none;
 d=google.com; s=arc-20240605;
 b=RFZwDNeo6py+UAJSEiPSK2GR0G7sgoObFAXVTCy1k+t60ktWM7VZpmwf446BjhtZuX
 H9ha8IfTlHPLKf7/CXk5jb31a6/kyFJbXfIQaPOQ+WYC08eLVLQNNJhLTKgzvDa7SdYS
 ePsp80NAFVYlnE5TnejsIaCqIdTzcpGHvbQPHOMqGNrao722/LI6diYF5b+TX5q6D+Qp
 7vRrWxsl5Mp+5j4E6AICZm24Sgk0pyy1MLafzx3SLMLVr+8rHpp4CTj13pkCBn9uaqDS
 ctRSuj62dBsuILTuH6WdEBedD7ztviJ8rj7FwcNtWBqcYLOQqD8T2HB3wWZSLlCshFq+
 7VFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Spy9t2o9wGWtNfNjhf0jiLHajNLRXFHQOMbKOPJUOSY=;
 fh=/t4OQDcQOw5Q+xwaXkOoWoUvxjtx2pxFeCZh/pYJrL4=;
 b=fw1CyHzF5eVAe1sPhdY4UDMp955OX4IcOA6FOP9QJ2zHAjIyti/M2jF6zNgqjaHvAI
 sDvn8B7k62w7KV9DXMk24xRiPVh7tlC57edLM/BTxwvPXj/48lAv6Om7RAvQ1PteZA+H
 Ze754H7f6ZDOLUa//2d61MoD/N6j0RCcwP0X8bO2q/RFm4TjSAlaufzhuLJCYrtXmhxj
 HBzOXGBeaQ8b/wSsiPQEBMNXKsBOcsGZVzoLRUfJ2iRAPUbJImpVjhWIMXaOsbGyLYRH
 IhC9ZguKnpmarBUjBaeYyKACAuC9aXJ/HQISr1gw/2jmXP89AiKz3k4jwFbbvBuooHCp
 0ifA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779195839; x=1779800639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Spy9t2o9wGWtNfNjhf0jiLHajNLRXFHQOMbKOPJUOSY=;
 b=ZVXUXHLFKtxZVQux17nrz0wHaR1lwT3RgNO6/UaZKWztYWnOs3GB7ZnNoo26RKO28C
 gSNxa+P1rm+S4bZTW1ZPKWj7jYkISDbMzqn+gdzPGpiHgql0bQamj/P3hkLJTsZZFdgj
 OrxX+Rw+z/oCHKXs/PKqJLyZYV3mbUXahM9lJ1KIJ/iJZMWHMEtkk0MDLCYYsH4PztUu
 Z1vqyI4w8TRE1AA+XwYZEQmKU7YZ3jgaSXb/Xyz3hg60FJBKHKXxAugma1FoZplm+ijv
 SMZpAfjLL4fIW+9mw13tpFR7l9EaGAUIrIh0sHgRfkY2PrcuPEQZUEjNus3yomdaffCw
 tz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779195839; x=1779800639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Spy9t2o9wGWtNfNjhf0jiLHajNLRXFHQOMbKOPJUOSY=;
 b=UVw4GeNygDq0ECgzBvMpGQZB8wmMJth5kHMRpUsvWuNFhn3sYkSH0aqf5YZE3qiIHX
 vtp6dpGWzdLMtHRABpCV8m9tgB9wdN0Sq1LMzG4zJYDsckDVOZhp1/XqVxSgCCmHVnmN
 i/snbv2Djv+HKxNs417PzfcHIHpxJWJkf9ODBMwNuSuNIdVXaQqHH8t8SJnmiDafVgLe
 rU+H2zvPLvhf5TaLJffNSNd7Ljb7iTC+xwtGn0ukedsC7hlztdXsk/wUH/4I691rqiT+
 6RUXr2Tw7HyJEUEqgI2WOE3Duu3WGEd0eRu9bsVNqSbHujJn9lBu34G7FdOpS7wUVBbw
 wuxQ==
X-Gm-Message-State: AOJu0YzcRwOyN7KXS64O1MpK+rMvebgpKHWFedMJNQz/V4oAgOu/09yh
 SLbTmBVYerDGaVpsLE+QjJmT2jm7as+x4ujM9r35EoS/Ezc9ZRNXMjApPII6tMlP6yqRoFVzoQk
 2j8clRZY2uGfVcA8CUkEqQRNeAPJHatC1EzYBWEkErLzFlFGNxlYZ5AU4VYR9oUiV7jp1r64MWm
 5FG0Yy4BeqFPIfR0zzU8EU/4CVxC6tSbqd
X-Gm-Gg: Acq92OHdqqXIe53uWGzx/mb6Yxg+cdeqnOKcBwUHQAaeTmlWsyOVjvfRSCWG3MBzbWd
 jp5FcHuMRYFuIdsu/gciN3fOkoVISiwxh5ITKINTrHLXPEQNJq8lZt1KKXye7X8EEOJU43GmIU3
 2GfY0eptjfnvJQtyo/w/RT4xthvfrm9iIkdKuvZWcwrk8qw8lRQ0w65JKQmlBjmU8zrXQl1Q+gU
 kdhoWp8
X-Received: by 2002:a05:690e:4416:10b0:657:eeac:6ba2 with SMTP id
 956f58d0204a3-65e22894d5amr15629244d50.46.1779195839242; 
 Tue, 19 May 2026 06:03:59 -0700 (PDT)
X-Received: by 2002:a05:690e:4416:10b0:657:eeac:6ba2 with SMTP id
 956f58d0204a3-65e22894d5amr15629183d50.46.1779195838493; Tue, 19 May 2026
 06:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260518102222.80735-1-philmd@linaro.org>
 <20260518102222.80735-2-philmd@linaro.org>
In-Reply-To: <20260518102222.80735-2-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 19 May 2026 08:03:40 -0500
X-Gm-Features: AVHnY4K-8cEcoPmFo55SydoD2-EYKikWYSMoeN_jeKbXvJl0YPzmVicJHN3Cf9E
Message-ID: <CAEqNhNbp4aU1Q_fZDr1fDeXk5+Zx763ZsptXbbBuKBu5ipJDng@mail.gmail.com>
Subject: Re: [PATCH 1/7] MAINTAINERS: Fix
 docker/dockerfiles/debian-hexagon-cross.docker path
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cleber Rosa <crosa@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEyOSBTYWx0ZWRfXwSfOfZ8bV55L
 plshzeJnSZLcFSk7eAoc7Gx46Ao7r/6xgr6mhOjXNIZc1ISz9ak3BcqeSIekKU0Ii7QTtoZiFvT
 cciwgIDWOzWEXwPbY706B/imAYE22q+Jh0/Jf7cZ4i5xQU7JCUGP8dkTjQGSjLHZGWv7EKzkByP
 Kipl25SXvBBO7ceObJDM7+5Y0s1AXrtmH8l7kLhKL8ltY4ZICtXV12dNcGLwejCssYH8CYv29Nr
 j/EAmzokaznY1NgAXA1aUhLFeo90IpXNkbXh6+kzIXRIdNnSHZitO3DLHqbmClSzeUfj95r8vU3
 aFiaJnDPXiYM0l3eNlKqa+wDg3fcFdF4P+9MYEOEnWLqHyUNfXk1/jGEol/0FZCFnSyjRV5D6hi
 ObZG19h8+NFczXZxWkq9vrzxDHxAxv2AfW/MulWjY72ZTFdHr6LaCYh2YZb9d2yAlcVeTXWHt5D
 q37N9429Yzy4RCvmGig==
X-Proofpoint-GUID: OfaiWfGHHQGTF_rGTdim9vh1rAhZ1-L4
X-Proofpoint-ORIG-GUID: OfaiWfGHHQGTF_rGTdim9vh1rAhZ1-L4
X-Authority-Analysis: v=2.4 cv=WZM8rUhX c=1 sm=1 tr=0 ts=6a0c5fbf cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=JtFe5XvjPaDV7MHqiL8A:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190129
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, May 18, 2026 at 5:22=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Fixes: afbdf0a44ea ("docker: Add Hexagon image")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Cc: Brian Cain <brian.cain@oss.qualcomm.com>
> Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eda1e84268a..b1df7a4dd96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -257,7 +257,7 @@ F: linux-user/hexagon/
>  F: tests/tcg/hexagon/
>  F: disas/hexagon.c
>  F: configs/targets/hexagon-linux-user/default.mak
> -F: docker/dockerfiles/debian-hexagon-cross.docker
> +F: tests/docker/dockerfiles/debian-hexagon-cross.docker
>  F: gdbstub/gdb-xml/hexagon*.xml
>  T: git https://github.com/quic/qemu.git hex-next
>
> --
> 2.53.0
>

