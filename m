Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9F5C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 15:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmnX-0002XO-Ai; Thu, 13 Jun 2024 11:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sHmnV-0002TE-IJ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:55:33 -0400
Received: from esa10.hc2706-39.iphmx.com ([216.71.140.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sHmnT-0005kn-RF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:55:33 -0400
X-CSE-ConnectionGUID: G1ysQ0PcTzWD5vQEKf1w6w==
X-CSE-MsgGUID: q7QBdGLSS62I1MiJH+s5CQ==
X-IronPort-RemoteIP: 209.85.222.200
X-IronPort-MID: 373232286
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:DTvrK6yXLV8Tiivczq16t+d8xyrEfRIJ4+MujC+fZmUNrF6WrkUOy
 2BLWmzUMqneZTOkeN12btjkphkC68XTnNRiHAJlqS00HyNBpPSeOdnIdU2Y0wF+jyHgoOCLy
 +1EN7Es+ehtFie0Si+Fa+Wn8D8lk/nVG9IQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwRgiAo
 rsemeWGULOe82AyajJ8B56r8ks14Kys4WhA5zTSWNgQ1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID733CuDgRrukoKHKN0hXV/0l1lrPgoo
 Dl5jqFcfC9yVkH6dEXxZDEDe812FfUuFLYquhFTu+TKp6HNWyKEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRj/alvmPmIqwdvtTqpk9FeTIMtoA5G41mFk1Dd5+KXzCa6DD5NsdxTRpw84URa6Ya
 M0eZj5iKh/HZnWjOH9NUMN4zLru3COlNWcA8Dp5poJui4TX5AV1wL7hKvLfZ5qHSdg9ckOw/
 T2dpT+jWEFEXDCZ4SPay1igqcv0pn2heds3FZ+YteU3q2TGkwT/DzVTDzNXu8KRk0O7RpdTJ
 lIZ/gIoqq498lHtScPyNyBUu1aBtx8YHsNTSqg0slnVjKXT5AmdCy4PSTsphMEaifLajAcCj
 jeh9+4FzxQ02FFJYRpxLoupkA4=
IronPort-HdrOrdr: A9a23:ciMtyKovhbp3OX2jMAxBjOgaV5rveYIsimQD101hICG9E/b5qy
 nKpp8mPHDP4gr5NEtMpTn4Atj9fZqEz+8J3WBzB9aftWvd11dARbsKhbcKqAePJ8SRzIJgPS
 cJSdkcNDWnZ2IK9foTY2GDYq8dKF7uytHNuQ9dp00dKz1CWuVF1Sk8Lya9MCRNNXJ77RtQLu
 v/2iLDzwDQHEj+Ra6AdwY4tkP41qf2fL6NW29gOyIa
X-Talos-CUID: 9a23:JP5YBG6Wyzq7NPIl1dss2xcFAfl9Snbh3kj8flGBJEVnEaLLVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A9ZMVUg9uDPz1ulQpeWTnwmaQf9432o6iJ2Q2qst?=
 =?us-ascii?q?cmpChNA5QeCzApw3iFw=3D=3D?=
Received: from mail-qk1-f200.google.com ([209.85.222.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Jun 2024 11:55:29 -0400
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-797e08e5d9eso133589085a.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1718294129; x=1718898929; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dhbyvWGT16zVh2jUWMQRnzM3yNBcoG2ynfy9femxJSs=;
 b=KlHg1GhzbAgMFRNUYh119JfdRECE25uLc0BsXAm183y1ZXy7qebjF5AVrg0eqOxUAw
 JofCdV2e5MG4oCdP4956RL4j8InhhhcVkdzYONGNMg2Y4zsbpY6wVLaMwUmiiAcAesji
 9RKpA7QSuMCEWfCXWAo0flKZsusNIstMOLOYf1edoaECJch3A9Iah7+sywdbY0EqeLLt
 Po/N+PeT4sy4OA2uyY7vRsRevnkjbPi3jxf9/fPs6xMH++UjobuFVPpWwQF1OZK8WmYD
 9CoXS9Gb/NzygpQF6zoY5/LeBIflJ0mVubhaaGHZvSrniNiyr1IMx/xidftjbODrUt3B
 2WCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718294129; x=1718898929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhbyvWGT16zVh2jUWMQRnzM3yNBcoG2ynfy9femxJSs=;
 b=MhK1rRys3WgwwILchb5Y04Z1HRUEX8YcJa8fR5Vy/Y4N8OnC06KLp1+qA+OavKVtjJ
 9PToRDW09b6kn6xeITH/IIIIIi2YwYfgAz71+10VipOckvOC+iCANMa4/hvZ0NDd/yAa
 3Vkm0kzaWkatdNkL0ZN7ECF3LrnWJj+4cp/qk4wHOVXOllmem1nuc6yZ6KPQ9inl80PA
 30tq1EGd1tedW72Pot8W7vFRXCOzQ1To9TEqrTmnbYimbRCeQSZgH9/PQT5TtGOp8uqS
 +i2+LHIF/vE1af+3u+ywNjoXIipRxlEcOjcaY45GFbPOAnnSJoKZSbcQaJvRYcsb9Jc+
 eh5A==
X-Gm-Message-State: AOJu0YwxVaLBhU0DFgLtqavpCClG+td/iTNirUo6xR4nAA0HMBnB0rWP
 o9pCdoBL/Pg/aoONOL+SpicDVNo0Qz4k+zSGvC7kG20C84dGgkaDWPCXVjWBN1n1uc3o0WBPdso
 f/X85K+0sZ4569nv7oZW+7heprGjk4/b+XcuZr6jCRj2bGzk5dFXcGzYIp249hv486Q==
X-Received: by 2002:a05:620a:4092:b0:797:d55a:516a with SMTP id
 af79cd13be357-797f6128e9amr615460685a.60.1718294129227; 
 Thu, 13 Jun 2024 08:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVnNSsBqQumuKErOIPO1AOzElnbyOBQjWu6ICerdzGD/8I8I/CGitjbX+RujkwsZLe0qMEVQ==
X-Received: by 2002:a05:620a:4092:b0:797:d55a:516a with SMTP id
 af79cd13be357-797f6128e9amr615457485a.60.1718294128736; 
 Thu, 13 Jun 2024 08:55:28 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798c39d8cafsm41860885a.127.2024.06.13.08.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:55:28 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:55:24 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, sdl.qemu@linuxtesting.org
Subject: Re: [PATCH] tests/qtest/fuzz: fix memleak in qos_fuzz.c
Message-ID: <20240613155524.ldxi3zjvsj2l4bnf@mozz.bu.edu>
References: <20240521103106.119021-3-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521103106.119021-3-frolov@swemel.ru>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.198; envelope-from=alxndr@bu.edu;
 helo=esa10.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

On 240521 1331, Dmitry Frolov wrote:
> Found with fuzzing for qemu-8.2, but also relevant for master
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>  tests/qtest/fuzz/qos_fuzz.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
> index b71e945c5f..d3839bf999 100644
> --- a/tests/qtest/fuzz/qos_fuzz.c
> +++ b/tests/qtest/fuzz/qos_fuzz.c
> @@ -180,6 +180,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
>  
>          fuzz_path_vec = path_vec;
>      } else {
> +        g_string_free(cmd_line, true);
>          g_free(path_vec);
>      }
>  
> -- 
> 2.43.0
> 

