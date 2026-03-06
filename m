Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931AEFCB620
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXrJ-0005Vx-QU; Fri, 06 Mar 2026 11:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXrH-0005Tq-QX
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:59 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1vyXrG-0007TH-GZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:16:59 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-506a747448dso83584351cf.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1772813817; x=1773418617; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QhQc/f/7W8WtdXpkT2k3+MRzozWZuGdM6cR2Yf8jBig=;
 b=iR54emxgAuiMqu8Pav/vSkW79+QVTH1goO4+3AkvNuW8jXJvDWdhQ+Vetsg3PnEE1i
 LPT93jUK5t0XL/Rp9geJADS5xt8XVOGOUcttgxVCAaj0oxfwOmFufQkyFp7OJifAQ+n+
 KOaW60F11incM983YzNiRHmlcGFqpoMKrPYdYk8W4COu38zcT+Hrab9Uy9DDrN6yqo94
 9CzqaFvSZgOQ7jZAoOM44kPFsnQkFrF/bU36yS5JbZjEwR5BVZ/wF5qXABhlYNJ0choS
 5N5tfIChgGUDmXexnZnqkuFEqOJbFXHTkF6xjeUIvfhDDgj/T37f/iqe/9mRXDBrx2lS
 favQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813817; x=1773418617;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhQc/f/7W8WtdXpkT2k3+MRzozWZuGdM6cR2Yf8jBig=;
 b=YxPsOmScwvN4Q8teOgKkAiaQE+0w6gR/M6iO9R9wmYzmJ+HFY88+9I24MyozcAWjn8
 zBin8RuAJbDQjK2WJarEN6Evx5LLX5rLN1QZ2R4r459Kd7aA3fYvY7FQ5HT8unEsixvp
 Qm3YjdnQycu9vaeL8QBNvrkxK8ApDfFapSYbAcB3/Bvc9T30ywZw7giVHYVb8j/AvrEw
 +p79oQN3Gzb0CeENxpF15gNkYbA8hA8vNY8cbC1swR5p36r4P3hNoNpqBXI+WeVoxXgf
 onpi9B98Tz4gckAadng3mz6EywXMHCabitmFHYVVwv2HeCbIR2geZHEkRXizKqVvwE94
 sr4w==
X-Gm-Message-State: AOJu0YwCAUIX4/T5j+1Ht3HUAlnJWV+ya1CfYj+b9yxz/CcQco2db9jc
 vsD7nYlDgtB+Ko0QQTy8GNUTGMjApoYX5+pwrGU5d6RGA17NzNronMyVH4vFt/q41wQ=
X-Gm-Gg: ATEYQzxx917zbmN+aChnX/qJjAUFWRjoPQ0wkdgTe7p0WMasDqkMYu/9ANpItTj3riH
 ay7Uu/3rSi/nDb4Bat3h0LWCu9orGH+goWZ6fJVyhFkWoPr03I4FOO2gCcDYYkiCB9YJugvlocp
 FpqG03+8pe4XFW6I2XV2E+6uLvjj2tr89rnchKiWO4UZiiBJSzkTayYI5N6I2pPq8ZF6/10ISVg
 r+Hp7qBolwjQqTdRbs1uJnETIYvURIe6Gxcto0ZRyF8oX0d3qvevSbyLzJtRCGh6NeuGgINak2J
 j9zGHyZ+ZW+swAr5USi0tcostGMM+8A77Nyk8VG+y7XfPSdKcMuS/L6yHxbpiwyDW8bPhzTss5Y
 wfNhtsdLgj5YCAQOYD1kjnlpY6a8+MwwE8p8+jjPJfj1aupwiZOZ+RHxdAPrGqJPgjUl3S1gaCe
 TPV3FWLyGHJKzDKMcSsdakk3f99DcXgUQZcZH73aQFQzzagQ71FdkUviOHaLn2pEVzxaT5xeelV
 lO7dfL17A==
X-Received: by 2002:a05:622a:1b8c:b0:4ee:1f22:3615 with SMTP id
 d75a77b69052e-508f49918b7mr32764901cf.51.1772813817484; 
 Fri, 06 Mar 2026 08:16:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-508f66d983dsm12483631cf.29.2026.03.06.08.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:16:56 -0800 (PST)
Date: Fri, 6 Mar 2026 11:16:54 -0500
From: Gregory Price <gourry@gourry.net>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, anisa.su887@gmail.com,
 armbru@redhat.com, david@kernel.org, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, mst@redhat.com,
 nifan.cxl@gmail.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com, venkataravis@micron.com, xiaoguangrong.eric@gmail.com
Subject: Re: [PATCH v7 0/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Message-ID: <aar99qQb9H9iyrRb@gourry-fedora-PF4VCD3F>
References: <20260306121151.883-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306121151.883-1-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=gourry@gourry.net; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Mar 06, 2026 at 12:11:48PM +0000, Alireza Sanaee wrote:
> Hey everyone,
> 
> This is v7 of performant CXL type 3 regions set:
>

Just wanted to thank you again for this, it has really helped accelerate
(lol) a bunch of development that has been going on.

~Gregory


