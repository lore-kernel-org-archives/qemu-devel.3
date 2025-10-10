Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4163ECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Er4-0007RV-Oa; Fri, 10 Oct 2025 11:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v7Eqw-0007Gj-Ei
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:16:19 -0400
Received: from esa4.hc2706-39.iphmx.com ([216.71.146.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1v7Eqm-0005RY-Sr
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:16:15 -0400
X-CSE-ConnectionGUID: R2nexXJmShKlyHTWKiYCKw==
X-CSE-MsgGUID: Q/F6EN7CSnenLjMceVmkGw==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.128.200
X-IronPort-MID: 81567219
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:qqixjaqFTDovDfh5W9/q0+Njee9eBmJJZBIvgKrLsJaIsI4StFCzt
 garIBmFbKyNZzekf9h1ao+x9ksGusfUzdA1Hgs//Hs8FHlG8ZacVYWSI3mrAy7DdceroGCLT
 ik9hnssCOhuExcwcz/0auCJQUFUjP/OHvynTraYZkidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8UIHUMja4mtC4wVmPKgT5jcyqlFOZH4hDfDpR5fHatQMdgKKb
 76r5K20+Grf4yAsBruN+p7nclcHS6LlJgOHjHxbQcCK2nCucQRrj87XnNJFAatmo2zhc+JZk
 b2hhrTpIesdBZAgrcxGO/Vu/4OSCoUdkFPPCSDXXcV+VCQqeVO1qxllJBhe0YH1Zo+bqIyBn
 BAVAGllU/yNuw656IjhTOR8tuYmF8nIOJI/hk5DzADyLulzFPgvQ42SjTNZ9DI5h8QLDOmHI
 sRDMWIpYxPHbBlCfFwQDfrSns/y3ii5I2Ae8QjF4/BvuwA/zyQouFTpGNPRatqGX+1fgwCVq
 n+uE2HRUkhHaoPFkGvtHnSEv6jhww7dB6kpErC+0vxPi1Ctw288F0hDPbe8ibzj4qKkYPpGJ
 kkJvyYjs6U23EqsSNb7Qlu/unHsg/IHc99ZEul/+R7Uj6SOu17fCW8DQTpMLtchsafaWAAX6
 7NApPuwbRRHuqDTRH6Anop4ZxvpUcTJBQfuvRM5cDY=
IronPort-HdrOrdr: A9a23:R03006jDvbaaERoGvD7GJKD0U3BQXgUji2hC6mlwRA09TyX4rb
 HToB1/73TJYVkqOU3I5urwXpVoLUmxyXc32/hpAV7aZnidhILwFvAe0WKA+UyeJ8SdzI5gPP
 xbAtBD4bTLZDARsS+d2maF+r0breVvnprHuQ+ip00dNj2Cv5sQjTuQdm6gYypLrXF9dPkE/W
 2nl656TpObCBEqUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3Ab4/cr2oFzmDaAtzjZnCj0ZLmUfp/dHDN/FXVGE+?=
 =?us-ascii?q?bDXdJdIK2SG6727wxxg=3D=3D?=
X-Talos-MUID: 9a23:HB6fSQSYf+UzRVw8RXTVwx88GeE3yJ+oBUYpk7ANtveBNgNvbmI=
Received: from mail-yw1-f200.google.com ([209.85.128.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Oct 2025 11:15:53 -0400
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-77facc9ef7dso34035367b3.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1760109353; x=1760714153; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qFMbl/+gCJ4AEaRd2KmxU1PBYZ82j9wdxr2Ok4itXDY=;
 b=UhBTCbN83XzKJdl5HSJK/YvDf0oVuYsKvtzkmw/VV87LlNtW+Nnw2mby6E0b4f/0XB
 fE9vCWJGWZPoI0X7t60v3dcPI2UfS7bWddXZvgAtOiZfP8kIrmCukgpQ1XCiUIzrN0dY
 vcJdkJX/1n+mC0BW7S/Pw4AUQe9fPcVGVh+EiwwV5XwG4teqWuGw8cTbVsuNEN/63yoR
 UAsxOyK2zO325JVapMPc8z/k0bA0cHcqgPDVZMx7sIAHsZDB216apk5vlEFXSDe8MW+A
 klzBg2eTbgBb6yenR7i5jje7gIz7iIkwnyhEw3bxASbVDX3plc43Mev0tOkKkPK/xQEB
 ZC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109353; x=1760714153;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFMbl/+gCJ4AEaRd2KmxU1PBYZ82j9wdxr2Ok4itXDY=;
 b=ATp+krsMf3Hz0R8X5oE7Zdj6qNhFnD2RwAooXh6LIdP3LmBpT7OH21fxgV6o1W9CA6
 lu/Fj4lFfBJsHZqx+IIJG/E9l2ghvTjj1dy3KfnLnDN5Xo2T4SCH/ZsbKVQk5frEcZ91
 JyzJLHWuQOlj/lfusMiABhG6mH35xkq/+eUIDGpv8fmd32PX9OP0rZDrpAoLjosdvrfQ
 J3Li6HAUhncWRO01IV7pejpuF7LpdlMTJwCjyp38V2rRmJZgN0Ei+CGfp6EE3/lCFpoA
 h5Yv5wKPHRhOIwxZ7zs0lqkxzjKy9XhYU63nZq79cPxDjh2pizaBxDO+LOtqesm+MBX2
 09NQ==
X-Gm-Message-State: AOJu0YwBwExY6lV0nvXFuOLjEoYZ21cJnAd3e/LgRX04oneyslQB8Gzr
 SLR37RTFPv7wkvnAw3UOVdCDIi38MwP/4wzI3j5kD3Me6l6WJLkOabvjl5daRhb2n4b3OuiCy6P
 WPw5W+Ga2CO/5UKoUimwWviz/fJR6BaHGtqBJboJTZXTp9Nnbs2Qj7s7NDMZIbo0Pkd7qoB4wDE
 Kw2SF0lYDN+iNMFP/sNRXtLucuvI8XlUvQ6iEuob2J9CzP
X-Gm-Gg: ASbGncsQ1SrcwsXC5OxD9QVzINu9LLgajxH84Ndp9HT30sF1KwQjs4N0/yP4bxnf0j+
 4Lz9u0tn6kODLKO4MNZg6BRuLNd7n+9uRVBu9IqHIf6Dkvlklf50Y49kn+qpByoQgaKfgU9Y3Gy
 bHrKI7cxaJBv9t+5kroZYf
X-Received: by 2002:a53:864c:0:b0:636:d520:32e4 with SMTP id
 956f58d0204a3-63ccb95f9e3mr8652940d50.53.1760109353240; 
 Fri, 10 Oct 2025 08:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFem3dJ1xPYv3DMTQb+O8qNJbIUQdORu6STKWKgSaEZwU8d6NiAGhP6sDVZDlH6cDTi+9WvPkyUJV+SKGys284=
X-Received: by 2002:a53:864c:0:b0:636:d520:32e4 with SMTP id
 956f58d0204a3-63ccb95f9e3mr8652895d50.53.1760109352713; Fri, 10 Oct 2025
 08:15:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 08:15:51 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Oct 2025 08:15:51 -0700
From: Alexander Bulekov <alxndr@bu.edu>
References: <20251009211114.2214848-1-navidem@google.com>
MIME-Version: 1.0
In-Reply-To: <20251009211114.2214848-1-navidem@google.com>
Date: Fri, 10 Oct 2025 08:15:51 -0700
X-Gm-Features: AS18NWB8tngrIh12GJZCjx4hqTCoHc6n48gQRCHP_Gfk6Hv5-50Na8SlDpHbsuM
Message-ID: <CAHUE=o-aypvXPxZXssD8nMJm+Qa9Nsp1HRcNVbC27tNkpV75fg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest/fuzz: Add generic fuzzer for VNC
To: Navid Emamdoost <navidem@google.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 zsm@google.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.146.118; envelope-from=alxndr@bu.edu;
 helo=esa4.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 251009 2111, Navid Emamdoost wrote:
> Add a new generic fuzz target for the QEMU VNC server. This allows the
> generic fuzzer to directly exercise the VNC protocol implementation by
> connecting to a VNC unix socket.

Without a client connected to the socket (or even a client trying to
fuzz the VNC protocol), much of the code will be unreachable. Still,
fuzzing this probably does not hurt.

>
> ---
>
> This new target increases code coverage in the VNC subsystem
> and related networking and I/O code.
> The baseline coverage below was generated by running all existing fuzz
> targets with the oss-fuzz corpus. The new target shows significant gains:
>
> ----------------------------------------------------------------------------
> File                       New Target                Baseline        Change
> ----------------------------------------------------------------------------
> vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        +336
> keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         +91
> net-listener.c             76/198 (38.4%)       3/198 (1.5%)         +73
> channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        +54
> qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        +44
> vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         +41
> dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         +25
>
> Signed-off-by: Navid Emamdoost <navidem@google.com>
> ---
>  tests/qtest/fuzz/generic_fuzz_configs.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
> index ef0ad95712..2e802ab226 100644
> --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> @@ -247,6 +247,10 @@ const generic_fuzz_config predefined_configs[] = {
>          .args = "-machine q35 -nodefaults "
>          "-parallel file:/dev/null",
>          .objects = "parallel*",
> +    },{
> +        .name = "vnc",
> +        .args = "-machine q35 -nodefaults -vnc vnc=unix:/tmp/qemu-vnc.sock",

Does using a hardoded socket create problems when running multiple
processes fuzzers in parallel? AFAIK oss-fuzz does this.

> +        .objects = "*",
>      }
>  };
>
> --
> 2.51.0.740.g6adb054d12-goog
>

