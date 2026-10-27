Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA15606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=j03jBJjc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLb7x-0007ba-Qu; Tue, 27 Oct 2026 02:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLb7t-0007Zz-RH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:57:42 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xLb7s-0002XY-9v
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:57:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c46822eefb6so493119666b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1793084259; x=1793689059; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dw1sdPL4tbSNXfnNMoDydP+VF2bhdsxJg7+5ckdvWKI=;
 b=j03jBJjcCvh4u8VXendcpNbd3uUN4HNXSWcdfShgPRoT4tAvHfGMG5I12PfhC69D4l
 Wj2IHF7685rcmqTG6GiZp1NwzoSjxcPSIYCuib0LCsesMCrfzKVvnee0p3P1XqVXtObN
 MnJcm+Wey1+pX0aSmqteb48+h8LZVv4zyhpsAgY2hmaagCOyLPrTV3lH9JIF+98MZW4U
 WANe+sdlJzrhNrn52GcpsVANz0qjraLTohngeH0XgDPzlkC9bKc3w6IlNfw4I4QfGPcd
 abSwnPF2bWdx2deuEjBI5L+hFJFCMVuJ+o3Jsnh5/Qd7IEBTjpPrAO479BXaeoICLtyo
 ZlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793084259; x=1793689059;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dw1sdPL4tbSNXfnNMoDydP+VF2bhdsxJg7+5ckdvWKI=;
 b=ydn7nhvjk/EXcYINLBdq4cQ3QlqGlqZNz73gytNOpzezlRfYhKEUrI5gY/5ZHOK6O/
 k3SOqNMvJxmBkJ2v1br52ccLkxmEL/3PCbwacmuCoaszDD6duZccYaAbwEG3lC29yF9u
 KRebaV9zF0qwUw2+VYqVDT7/k8qIwsziAnce+4HmTmKUHlTF/0Q2J636IwijvHCPS34M
 hzz/0rKzCGxQm9mtHAOGpelJPHL0P840l/N8OySG82+BxWpWL8TsgWF7NFgyBl61pIEG
 rI7NBZ9U4Xan3NBJ7ImNBGKNRPEg6fc2c+d2rCZ6NW+TH1vUbR4T+eoGbjFRDqKu08/J
 BPQg==
X-Gm-Message-State: AFq9FYIeLWvsLPOn4nbSuSxVSKLPybU2qSXm9hC0Rk+oy8Vfha2gwIvi
 iTlWSEiTvQvKnSL4+EY5g7NwdxbDOEz2+I6foM41rA9A/qBEe+4rGu9YEuKDPBrLt2RziknuuBu
 EyQ+RD65Xhm8GNzjfkUFHKE/o1oO/YXUYxluxbVGeU+3a+Wxf4Zlp6U5PzUeNhnEdjyzzBEn0ht
 uTjkgsBVvX20gHPxm2Fr+pGh1dCwz6+L8DkEtd5JHa8Nw=
X-Gm-Gg: AYBFou16Eq9/UZ/982vVwY+IK4HuwIwf9tqlpoVLtWnusjo4hlgooWL+8wDF2hbvh4v
 rgXnYa+ujDWXv6w5Zk0Gd0yUiPwMC3HGj+B/iNxlz+V7Afder510rKDD9Wbf/XYh9tNmYeif6JU
 sg+S68di/n2RJWtqurNHjt2li71t9xMEzfG267qJB1XFq7nbCdMvq3he2XRKuCM8ixT6RW14DFb
 JWjJUtxLWGI8qZIXpp9BDvnMSrk6Asl4ih6kWvux4sCy9bYkFrs9vdo/w+u9WESA9WqYSjBn+tV
 vr8hBGlzn9BLGi3OlD9h4qcWAmXmbsLuGa89VvQKcXnKCQ/FRyepIwfzJY3WFKxU3bwiyzuPQm9
 YdX7kGewtIjEem3z9dQj3JyjV5Wl1OblWe+pLIdKA7oQCA4YCDrMdC+Pe/vE/dKR4+AbU8BG36f
 hq5KeBHbBz9lbGf6PP//qffZ2axZRSkvKGNu5hGyWJlwEtIARNz1fhnfJSnXO+b7vbnU7LhqIdl
 AjO7FzYYfmgdd56Um3J0qK26o/CCE0dKqKbYS112bqpEHOjCfMKMIYihngJ0vd580pbjOT5cSBj
 gIQB8RH51ChacARNR/qhvjkC7ECYIYr1hZ79ZMg=
X-Received: by 2002:a17:907:7208:b0:c40:4965:72c3 with SMTP id
 a640c23a62f3a-c46bde08137mr964695566b.19.1793084258780; 
 Mon, 26 Oct 2026 23:57:38 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd66c2e9sm403927566b.58.2026.10.26.23.57.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 23:57:38 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so5533903a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:57:36 -0700 (PDT)
X-Received: by 2002:a05:6402:5514:b0:6b1:b5ea:2590 with SMTP id
 4fb4d7f45d1cf-6b442fc8bf5mr9881276a12.12.1793084256068; Mon, 26 Oct 2026
 23:57:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
 <20261021231346.2452179-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261021231346.2452179-5-daniel.barboza@oss.qualcomm.com>
From: Jay Chang <jay.chang@sifive.com>
Date: Tue, 27 Oct 2026 14:57:24 +0800
X-Gmail-Original-Message-ID: <CAMXXpfaHo0X7Sz0=3_eX+CuLcwvrBxJ4TgS_dTc14BKjoA7iuw@mail.gmail.com>
X-Gm-Features: AclHuK9mRfotUtAyfGtMPcM6tAuszmQ-F2f1TRNlb1iTymLbcf563mtsAYnfOgQ
Message-ID: <CAMXXpfaHo0X7Sz0=3_eX+CuLcwvrBxJ4TgS_dTc14BKjoA7iuw@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] hw/riscv/virt.c: add trace encoders and trace
 ram sinks
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, antikostya2@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: multipart/alternative; boundary="00000000000022aa24065eccf636"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=jay.chang@sifive.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000022aa24065eccf636
Content-Type: text/plain; charset="UTF-8"

>
> Add the minimal topology required for e-trace support in the virt
> machine, e.g. each CPU will have a single trace encoder, and each trace
> encoder will communicate to a single associated trace ram sink.
>
> At this moment we're not going to support more complex topologies with
> trace funnels and so on.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>

Reviewed-by: Jay Chang <jay.chang@sifive.com>

Thanks
Jay Chang

--00000000000022aa24065eccf636
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">Add the minimal topology required =
for e-trace support in the virt<br>
machine, e.g. each CPU will have a single trace encoder, and each trace<br>
encoder will communicate to a single associated trace ram sink.<br>
<br>
At this moment we&#39;re not going to support more complex topologies with<=
br>
trace funnels and so on.<br>
<br>
Signed-off-by: Daniel Henrique Barboza &lt;<a href=3D"mailto:daniel.barboza=
@oss.qualcomm.com" target=3D"_blank">daniel.barboza@oss.qualcomm.com</a>&gt=
;<br></blockquote><div><br></div>Reviewed-by: Jay Chang &lt;<a href=3D"mail=
to:jay.chang@sifive.com" target=3D"_blank">jay.chang@sifive.com</a>&gt;<br>=
<br>Thanks=C2=A0</div><div class=3D"gmail_quote gmail_quote_container">Jay =
Chang</div></div>

--00000000000022aa24065eccf636--

