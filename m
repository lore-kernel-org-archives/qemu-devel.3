Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B6DC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrXb-0003nH-8P; Tue, 25 Aug 2026 09:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wyrXZ-0003ld-D3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:50:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wyrXX-0003vY-Kw
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 09:50:13 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso794920166b.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 06:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787665809; x=1788270609; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R2iz6X9vpQkrnDw0JUgesRW1kCxGnftKGSmfjLVpShI=;
 b=EHG9RYNYfK4WqbFTQdRXLiOlzQrV6hg5pz6kOeKRlEp+Lq7D8BTVjnbhn2YyBOZaoc
 nYaDXbat55MJChvNByk6ChT9rDtUXNsmdgTqm0/Pl4mp4XqR/qBexLFMW7iDmRtEz2sh
 hTb7F502PbkIKESTYlk10dBPzOmu9hSShXgMS7n/abYfuUvpZsz/OrcKtnfTu1ZuFPHh
 536zG0cIFfCdeDucyrZdnOEN3DM1NAfHdwdzGdOzqGLXsXz0dY9vB47Ha+j+p28Qfbdo
 0leKd/QviU6xfeZhBNKqlmeFoN5hmmqX3NgmvQhMTqaepf07USUmA5GcLdhyfKAwuOHO
 BpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787665809; x=1788270609;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R2iz6X9vpQkrnDw0JUgesRW1kCxGnftKGSmfjLVpShI=;
 b=hMNXvemo4iqejvqb1FWuBuJcpxLl6Q59AWIXyur2lA3Ir1Gdeqfbt4xYeS4Ga5/bNf
 tyDgmqYTs6jctET0t23kS0xzhgpY3UxW+T8554/Qsv3wZCExHkBWyZTk1ALUzZ/jPkac
 76YqY95WPD5mFleM9PgBvr7qV7Wj57BCOjN5onbddQbp6BooUySv+BfKl+thylBnIZzs
 EIesUWQeLqIXpG6l6bjBkAnSedprcdwEPAb7oV6ixyTJVktonjtDy5pYN3IV90GjRny2
 qGIp+WBakAo5UcXSfHiG63X57cCDRkv5jiIaryJ9htd+P2R7SOik2dqY4MjP4Wl3sGpq
 id6A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvHTeZmB05XH1Xxjc5naSHn3HCQ7eqcyHZ/iO+XDAdj9Suc+p5j5lZ9er/JyAWzEmzXDwPW8n85mBv@nongnu.org
X-Gm-Message-State: AFuF++lLgw1ZKmisEnaLrl90ws+WPCV9ChoxYJ7hPs2DhxzZqp17D7ae
 Ap+Rn/i0PwsgyebQZccNcPn/Yby9jolYpdawESu+SK5cU64ZNXQi+zWOJ+fafpQK7AQ=
X-Gm-Gg: AR+sD10+s3z0yB/xJllMuNSjXGTVozzI7wqg17nIVaAg3+kw7N9O83OjdAVrhMigdxl
 CYD4iCTqZyAKW0IRzChaUTxWm7roCk6W4Q0pABsT/PShk0pY+1/rI29PeBil59oqJ1HlaMtHv94
 GcgpYx4J/j5/hdfG9jola8DLKu8VmlyqJzeJ2j363sQh1j/ZzweaRDO8t7EQDNodlp5IRQ/rOZq
 A/6RXLSH9+5gQXuSf+LlebnUeIlBjbSlFZv1KqkUENulZwsOnp7fImL7MF7165T0X3iqIAz0Ou5
 uk4s81IkooO6l8Gnm34okdLgbQh7a32N2dbKD+CTNFXdJ74b3V4jOVMoaiuGYJ+BaMlGD2EW29c
 0/HwCVoxL3A74BMN8UzoMJSmBNGC2GpqGdTYyBpgbzM9Add8HpLCpZ/UCZPeKmjNsAm980q338E
 K965oPCpPOmvItaomV0Yuz3Sqra6tsaddL7YtJKImw1d03u8TeJ+dnR8B+vlU5kII=
X-Received: by 2002:a17:907:d0c:b0:c20:d90b:2cb1 with SMTP id
 a640c23a62f3a-c249188eadbmr3038148766b.0.1787665809576; 
 Tue, 25 Aug 2026 06:50:09 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:8679:ff59:1b3a:5e93])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2da49bsm15832653a12.29.2026.08.25.06.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 06:50:08 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:50:06 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 27/28] hw/arm/smmuv3: Add secure bank migration and
 secure-impl property
Message-ID: <ao2djuPIvi--MTI3@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, Aug 14, 2026 at 12:26:43AM +0800, Tao Tang wrote:
> Add a secure-impl device property and advertise it through
> S_IDR1.SECURE_IMPL. Reject secure-impl=on unless Secure memory is available
> and stage-1 translation is supported.
> 
> Usage:
>     -M virt,secure=on,iommu=smmuv3 \
>     -global arm-smmuv3.secure-impl=on
> 
> Add the smmuv3/bank_s migration subsection for the secure register bank.
> Serialize secure bank state including GBPA, IRQ config, stream table and
> queue state.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c         | 93 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  2 +
>  2 files changed, 95 insertions(+)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


