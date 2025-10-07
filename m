Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9F5CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67pe-0003e8-EM; Tue, 07 Oct 2025 09:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v67pa-0003cx-Nn
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:34:18 -0400
Received: from esa12.hc2706-39.iphmx.com ([216.71.137.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v67pR-0005dh-0A
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:34:18 -0400
X-CSE-ConnectionGUID: 1MJNjFkTQ9ycWTHRaQhtpQ==
X-CSE-MsgGUID: zREatULHQni/VxJ8ECLIYQ==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.128.198
X-IronPort-MID: 81658807
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:yL+K1aLJuTfrkWOiFE+RgJQlxSXFcZb7ZxGr2PjKsXjdYENShmQPy
 DccWj3SPauCNGLxfIp3YYvg9UpUsJ/WzN42QAJorCE8RH908vbIVI+TRqvS04J+DSFhoGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9z8ljPvgqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziJ2yDhjlV
 ena+qUzA3f7nWckWo4ow/jb8k425Kyt4GpwUmEWPpingnePzxH5M7pCfcldH1OgKqFIE+izQ
 fr0zb3R1gvx4xc3B9q5pa3we0sMT6S6FVDmZq1+AvXKbrBq/0Te445iXBYuQR4/Zwahxrid/
 O5wWamYEm/FCEFudNM1CHG0GwkmVUFPFSSuzXKX6KR/xGWfG5fgLmkH4Ojb8uT0984uaVyi+
 8D0JxhUSzKlhcy1/IvqW+JTuuQZJfDrIJsm7yQIITHxVZ7KQLjGSqTOoM5HhXI+35EeW/nZY
 MUdZHxkaxGojx9nYA9GTsJj2r7y1j+mIm0wRFG9/MLb50DayBx33KLFOseTd9CXLSlQthbB+
 D+Wrzymav0cHM6l5DOZz1aMv+nO2h3retI/P5mZx8c/1TV/wURWUnX6T2CTuPS8lwuyVsxSL
 2QS/Swhq7V081akJuQRRDW9qX+A+w8DAp9eSrxqrg6KzaXQ7kCSAW1soiN9VeHKffQeHFQC/
 lWU2d7lGFRSXHe9FBpxKp/8QeuOBBUo
IronPort-HdrOrdr: A9a23:Z+I6h65c0GsgD/+tLAPXwDTXdLJyesId70hD6qm+c20oTiX4rb
 HQoB1/73XJYVkqKQgdcLy7Scy9qDbnhPhICOoqTNCftWvdyRCVxehZhOOIsl6QeREWtNQtsZ
 uIGJIOcuEYY2IK8PrS0U2TP+xl7uO60J2Fs8/j8lYFd3AVV4hQqyl8TimWGlBrXwVdbKBJbK
 a0145oo36Pdx0sAfhTxUNoYwEAnbD2fV7dACLuziRIiDWzsQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AK1MRcmm2lirpLdzsue33+4NAyBXXOST47lHSDUy?=
 =?us-ascii?q?EMDd4Q4KpaWWZwaN4i/M7zg=3D=3D?=
X-Talos-MUID: 9a23:QWvxAQnDcoREaclZhex7dnpwDuph/5mKKHkLkNI4q+vUGAdUGgak2WE=
Received: from mail-yw1-f198.google.com ([209.85.128.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 07 Oct 2025 09:33:50 -0400
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-73934dd7a22so83979237b3.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1759844029; x=1760448829; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j+iUoJmBcXV9+gdndS0gdyyKWmMN222gbz+RWr1qoiU=;
 b=F3FdGu2d6tSZo1zhQOQ6CvtM8+HFDUJqVClHB/P4OOSU66ZueeA+XQ6LrHEtWZu5FE
 t9wDtEoWlPq9Pm0XjlewKmssI02cUFmtLWKfFzNGhoUhKVpU6u2AR8g0p84/XRNU3OQJ
 RIjdXeyAj8WY13rEmwtB9k7nZpFhP3jQacJHfVV3Lzc9KtbNf1pWK3Bf3i4gbA4alva5
 o5ZOwEuaxvSgEtK+Eld+BG9io/S4qdMnUKqFIiqtZjAFQmeBgBn1GFgNVCmBOjilY8dg
 raclxX6PXL8NPcTADsk90nYw2yaQyu4fkV+DVRAVBzcgKwzvVW3AbAyyUigDRLvcI+VY
 YOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759844029; x=1760448829;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j+iUoJmBcXV9+gdndS0gdyyKWmMN222gbz+RWr1qoiU=;
 b=kCDGXSiY0mkshHgNEaYDudNaGPZ32uFiFuyDYUgF/E4IMq9wTlWxkycyFGnZiXa5Ut
 1udi79IKw8kb3aK75GbmQRGzVDo5FaJr8d+GHw+8EbqRQQPI5QGYcztOqOyCZ1nC83hJ
 Yysv4VQEovTyDxGe1eqmrsLrUNJu0PQ21+ec8llaAt24lM3bdGgQ0CNe8iyQW/u0zqaP
 bDEb3Pu5GT6CFKYZ5+TDwJ//5R8401NRWLyZ44EtGd1BhFvbJM4fwTL6+juISd8Yzbjk
 GseMGRoY2yCoMY8EVSimvdzJgkWs3dO6C0VBwQxraloK37A6fHjvwyr/sqbm60ICYtcT
 zJ4Q==
X-Gm-Message-State: AOJu0YxIHgcwmIkH33NTILURzkxx/yy6F3K2DXDwMT34zaA5aRg/TX3R
 kbdAw/SgaMxaUtcU/k6MyrxvlWsBG9uHcSDEFJdXIM3Uk0rZXsfP1n1aDne1RhxfjtWma7gN251
 Trnj4K541dxLA2Lpy1Ff3uTJFICBrIlRpi5iwt6Hhu5CWnrGwniLblbwIBlWnpCmnt/xzGQb+5F
 ibTwFzTQBpKH0i484ckRnHeAe9LCIS1wmpYrFpFt3IH0/i
X-Gm-Gg: ASbGncsCu0rSOdNcj200OW8HT+59HfEIBj0k/ch9wSTXpn2tHV+0YSdWbic6ZYVKhqf
 icDxxPZsMMnLlvLDpiWvR2N5ofvEJddUNb8PBFaqX8UOQVW79O9LzIzaFYB2hpCUS8boUyPCCvC
 t0PuFq2mo6u5I4CF1jzeoMD3cHIA==
X-Received: by 2002:a53:ca4c:0:b0:5fc:5d98:3478 with SMTP id
 956f58d0204a3-63b9a060b49mr12170782d50.7.1759844029265; 
 Tue, 07 Oct 2025 06:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdlpmbE47zBh5ZUfFUan+LUxRQhnHQIVi0/QJhk8fedJPwye6/5pi3NfkE6O9TRt1H/XEvOY6FsveyhNnUbPw=
X-Received: by 2002:a53:ca4c:0:b0:5fc:5d98:3478 with SMTP id
 956f58d0204a3-63b9a060b49mr12170733d50.7.1759844028766; Tue, 07 Oct 2025
 06:33:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 06:33:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 06:33:48 -0700
From: Alexander Bulekov <alxndr@bu.edu>
References: <20251006222642.691067-1-navidem@google.com>
MIME-Version: 1.0
In-Reply-To: <20251006222642.691067-1-navidem@google.com>
Date: Tue, 7 Oct 2025 06:33:48 -0700
X-Gm-Features: AS18NWBJqqkuAPEvqQtTs1uq4EpqbJ1g8zkDYZLGrxRoIVTnYdpSAhBqaTwOTt4
Message-ID: <CAHUE=o9wp+AN=ONxuRuLH_8Lj1uzu4ObYB4d3PK1F6YrFi8LAA@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/fuzz: Add generic fuzzer for pcie-root-port
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, zsm@google.com, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.82; envelope-from=alxndr@bu.edu;
 helo=esa12.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 251006 2226, Navid Emamdoost wrote:
> Add a new generic fuzz target for the 'pcie-root-port' device. This
> allows the generic fuzzer to directly target the device's interfaces,
> which is not sufficiently covered by existing fuzz targets.
>
> ---
>
> This new target significantly improves code coverage for the PCIe Root
> Port implementation. The baseline coverage shown below was generated by
> running all existing fuzz targets with the oss-fuzz corpus.
>
> File                     New Target      Baseline       Change
> -----------------------------------------------------------------
> pcie_root_port.c         67.7% (86/127)  10.2% (13/127)  +73 lines
> gen_pcie_root_port.c     68.2% (45/66)   28.8% (19/66)   +26 lines
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thank you

> ---
>  tests/qtest/fuzz/generic_fuzz_configs.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> index ef0ad95712..fd2ae47ca4 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -247,6 +247,10 @@ const generic_fuzz_config predefined_configs[] = {
>          .args = "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects = "parallel*",
> +    },{
> +        .name = "pcie-root-port",
> +        .args = "-machine q35 -nodefaults -device pcie-root-port",
> +        .objects = "pcie-root*",
>      }
>  };
>
> --
> 2.51.0.618.g983fd99d29-goog
>

