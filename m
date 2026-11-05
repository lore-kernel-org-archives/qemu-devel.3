Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB29606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b4WgsQAn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxmJ-0007w2-0Q; Thu, 05 Nov 2026 08:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOxmF-0007vc-3k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:45:15 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOxmD-00056U-ID
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 08:45:14 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b31448caccso16268497b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 05:45:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793886312; cv=none;
 d=google.com; s=arc-20260327;
 b=AiAtc3G+Dg3UQxDX94g+vNBp9EpbuAdNfGQ6Z9X9RiStj7ZGL3S5JXpvt9HyzVEPr7
 B+p9JdUkK/gIOSQAxuq3xFY304+oN4OaI/aYkqjmTAt+F59BBAbZ1d6kdNPvRWTjCrD9
 Vs7BZ/D/LUXhBPjI5KUNi35e+liRuTsbVcsKFUkL9OZh1BwAgVjXnyk8LGCUeJq6RX9Y
 X5wAKp9aOy1A0HvUepqegE0OcSk5JljU9r4g0JNy0oRXEvSM9z2e/s3/HXlZfoJTeSTy
 L5zQYXVJHrE1JSOOzhJqY9460cOntPS1bTbmDFgLuMmhIkJAkJwGnBQkZ7Z4DqlWQJSC
 1cHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4xHjQ5+iisONzPEzgfEzYQovtvJlwye3sZPa+H0ZY44=;
 fh=/bxkXR68Nw8qyqrrRMpDGBX4MGjgUipkQy6RWzxY2lE=;
 b=Fol/PeKytbG/lcQtrqWqMhvEHSbt09fgv5a/YZUrcO8WXyPMNFW3S+6lhMx2br58Z+
 r93nBmtpC1XisygyGlJ3v6JknhnqAp3ytbRIPcfAnQhImYUl+0IRJntfBRTGIi3SOqe4
 BFKWZjws3f3xgy8Ud+jSUebDisGfDGXHtByA7c9hkyQFSpeHOPnYsCMcmg77H3nM5LQt
 AO5E9Nmpl+jJs88Lpj6VgXGM/UHkyUWkVKv4Qd3CfQR1VkNQBquBi0grvVrRf4JKw7WZ
 yXSDT+rPC4jFRFyqSDc6vTcsFQBxfixVxCXu0pqa/eEiIQ616m4E2o4JiAgItsy1rVw8
 lq8A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793886312; x=1794491112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4xHjQ5+iisONzPEzgfEzYQovtvJlwye3sZPa+H0ZY44=;
 b=b4WgsQAnyK4Ct+GtFcFQk2pYcdAouVUmPEoc0fxSHbwLS00AJvc734wd46acRIvGZS
 6gEe5ArDx60H2JhDspN6MoBBHj0U14rTAg5HUmpwIsGBM5evbd/gXGj6yKiDYsJKb6HQ
 eRPvMIR9ikDdYDuDGcrBVlMCuqiyonLx0uqz/v4/fkL8u2ntQZKAhVWfUs6PwSPOAyr5
 6qBBQw+vAPpUwALognU7Ecy1mEMOnVy2n//h6uoN6Dr2WlRchs6ONKVzY4nU3MjNy3dj
 mcoKUpSlG6TynoHi3xRuTLYXmHlFttgrBpIFzSO5Wh0mFLxquX3TP2OpkLlZzxXmBY/7
 PMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793886312; x=1794491112;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4xHjQ5+iisONzPEzgfEzYQovtvJlwye3sZPa+H0ZY44=;
 b=mu7mFu4UNLrBC6R/YT9hHxHHXh3yRzeccpeaEN2dSdnR+2mkZ3UdxJOLSOsazB/Pnu
 NQd6I9/P3ae3NHi8c7VwZDkV/2cJnIRIH2QtP9In05O3nALqG+21GdwRVL+duuasaNm4
 asAJ3PEfl0bBo11gK0kixhLujWPw1f6WKbx/lPCu/XyLbuguAYWBIuxJptxIVngQlDns
 703shpD5pEvL8UpSmVvPJ1l8yJuTiUaiXHM3Z5xdMZftGhW2Wn9QhZ6+P6o5lzm0jHkg
 L2Krhx20Ly34Ud4NxyuC6cYQklygzDqCZiV1hrd4iTDHLTH/Db+fLmAiWDC3yEyuRBJ/
 qrHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyr/DpHkFYyfE9Z94hvvV0Wm+bIh7904afrgAm1ynqMZ6Wlviqb+X0UC/OusWjwrwsu5tonDTq2qRF@nongnu.org
X-Gm-Message-State: APuU4Z+ttW3aFjOzF1930k4M/ARpAcxZRRDdCeXb/y83js8JNRUcbtHf
 8BISFmfP+JzdZG0mXk1ASp20/7GDzSV4xmsLNXU5pf7MVPexxCeTXA4cNNFdwu6bD8AxIGspxLV
 9jjJogHqzrQAIwtZKuVgFxf3HCunPiacV78lwnicOig==
X-Gm-Gg: AYBFou36QVjdp91d4JMRk4C+5f2Y4ZIXb6PuYuc6sXrtyjPYp1sQhwqiDsMVl/Q/l/E
 tYouHZ1nFyTOAsX6RjNehg10dDw+g3kdPumS0VQ8+2sfugvb80JzhVDgKDRLOuTYSP/NJKNHRLU
 k+NO19S5+CU4sI0tO0wJ3HUcIWolbyilanDfsy57WIjQhWTKYQjFcRYVlSRdz/rAXkdIoGG3HaK
 5Pqn8m2Ht+GLeSH5n7WWd4C9hTu53xfEtTHC+kZALbq57GpFQ7DRA8zmcNcH/zIHntKtgGgkR1v
 2l6qQfnCCtc0YW5u3xhtkFI7vI+K0GulJuexmZoN/cRwawxbbh46BNWiU4ac+3XwX/HPy8xUofi
 jdw5I64G1ncqI3Qefl0W+wms30rqPLWyEzKXtaSojUY4xjYepbg4nLjTOKZV9GklQ2DRnoD8O8G
 Imh8gRDH/t3jWbzWJl88/o
X-Received: by 2002:a05:690c:c146:b0:8b3:2e4f:6bfd with SMTP id
 00721157ae682-8b3388bee1emr3520397b3.15.1793886311578; Thu, 05 Nov 2026
 05:45:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-7-luoyonggang@gmail.com>
 <auxgsFyzv-5UiyNk@redhat.com>
 <CAE2XoE9J++-BHL5BDx4_jxuto+xwVmvFS3F-hE9gLbgfUmaFdA@mail.gmail.com>
 <aux5vwTnbV3cXcFX@redhat.com>
In-Reply-To: <aux5vwTnbV3cXcFX@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 13:45:00 +0000
X-Gm-Features: AclHuK8Nu7VnKXQFeeQWzk1m09hU7tD29uXNUYrg_NDcofC4G44XRULIcdXEzaQ
Message-ID: <CAFEAcA97kTiGVdPO-QtEkQ0+AuVS1z3Ctfc-q8bJJnEqFwavCw@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] target/arm: register separate max-v8 CPU types
 for arm and aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, 
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 12:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> So that essentially matches the historical semantics where one
> CPU class magically changes its behaviour based on what target
> is running.  So in that sense, it works, and is no worse than
> the semantics we've had for 'max' models forever.
>
> Splitting into 2 distinct types is worthwhile if we want to
> make it possible for the aarch64 emulator to support a runtime
> choice of both 32-bit and 64-bit "max" models.

What would the difference between that and configuring the 64-bit
capable "max" to not have AArch64 via "-cpu max-v8:aarch64=3Doff"
(which should work today) ?

-- PMM

