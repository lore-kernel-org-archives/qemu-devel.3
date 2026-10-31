Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D2B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W41sDnpR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN8lf-0002pX-4S; Sat, 31 Oct 2026 09:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN8lV-0002oT-TD
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 09:04:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xN8lU-0006go-2S
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 09:04:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b47c1a3c74so2059388a12.3
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793451893; x=1794056693; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3kpnxy/dkNVgLeYH9rmGoeq5+ddp6wHYdgw1ctYbh6s=;
 b=W41sDnpRkpwut3ePIqLNG8VONVfL0vK6IrW6wvWEm54lUsOQZWa3Kr/9RUNrpznGB1
 kaAmQoSbaXUthADaZaUqgPeDvd8f3rcvqjE0Hrd+oG2krPqTUr48aSeFWPCp0kYGHrgK
 PFtIhEnQektgsOz/0D0lRR+FP/Ya3aHEVBDgTMSLb9jsXEfb+AXUFE+KQfQ/GPBtR8tc
 iXcFV7jiqVVm0ZHcQ5Ljq99MbfQ+N7yI2T1L1uMpfYZ01pdZbcBg8Pcdbv/CA5FP8hgU
 MbA2pSxHb4mieyIe40731vn8bxBgoN162Nho6++k4WMbo1/mGBJCezCcPswKbPmreYj2
 O4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451893; x=1794056693;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3kpnxy/dkNVgLeYH9rmGoeq5+ddp6wHYdgw1ctYbh6s=;
 b=HX95Do3KLobb8HFUQe5Ff0o9LqvwuKZ6O+Kgv2qW1xnzLMrO6EcfgmhSYYuA03S6tE
 6+ua4i3KfHVedhaxhLYvRhJ0oLJbVom8OTD2DniwKWprFvZiLEZCuywjQDORZhn2ahq4
 YM/710qcJPpWW1t07Qn2x4Bl2VYYl0NxqBXPDxKY7m60sFnOdb5UOpbfha/7P2Vi7dcS
 Bo1DsjDfHGaPLCrnatZ5dAzor1Cx/XwVb8xjVHdGup4P6CdfPL+dWAnPQHu65fJ+l3ys
 0VGTkW58yxmPFqBa2Am9SENiDwNAK+Vhe64fE7JfvRmiUwkEcKrIBqaF5/wj868sJdLQ
 Tjow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNY1bAKd5NNBEfTevB6F5rcGICUptsJSj1l1Fx7q+0wRXEkcudw17KsFTX7CdJtkZxQRHuCB0O5Y53@nongnu.org
X-Gm-Message-State: AFq9FYJAGi+zzsQiH+uJ98/enASpyKb13CYhI0Ed67/S8wtaM1YqjLc0
 6SofSXyENC/NFFlAbICSLHTmOt+GhmwHRkb4IprseuDnnnw7BPKZrk1W
X-Gm-Gg: AYBFou00uMjZqN0Z7cPXAbZX+0gWwWQxpEQz0PJrKVhWCRtBXVaIjUs1X4HWB7+ypP8
 KTgcBT+Yynr4cXtNlS0o61nt/R1bqE5bagcf5zzLwmEmSZ3rtDewe08OMJi5UV4eICuIDGX2m2v
 3GW6DLz1JslfU7A4XMK7Q2gzCMoiZwzlIdafRQPR/MXZK4E79itZhKcDEgYyGnkqG8optYEb1TX
 8TMC4MQrLhc10SaIqCDJMjxVFPlU0/I2y1OMlbeEiLCWlwm16mbQvGtE6V0x41dJ3fTKSnXAteT
 1KgI/zaSAK5Y12s4Fx2vRrCBrpHY2jcxhxIckw4eXi1DQXoOZEPlDCPDJSmO38pvnxRt3tPkX8f
 uFcBgGj3xrlN+64nB9lXP51xnIcTXrwhAI1llBeoIX4lkLSz+TsUi7VMOsMAON1thkgs/wfy2Ql
 vF5OU8eASZmBwcQg4xH+uerNZIWhqJozianzcysbyTBNDcIweI06PhnaD4hkJW2wvIBJS9xlgQQ
 QjKeqzF7EphJ/A9/sAISud/R7CdernxrZjWyM/sbV+Eqc7+ABb2XYm9eO35W57otB4i6OQxXeYa
 J5mWdRDGzBCZuNWzHDIeyYq13BRQJTl09vFprPWM1M7QWgXAAcg71B6tW6zpMX6cT8JAAv0srJ6
 7G7q62deA5YpPq9LrcT0XfYvnhw==
X-Received: by 2002:a05:6402:c9:b0:6b4:12df:3ee0 with SMTP id
 4fb4d7f45d1cf-6b4d4c73442mr2564739a12.34.1793451893046; 
 Sat, 31 Oct 2026 06:04:53 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-25f6-628e-6064-de9b.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:25f6:628e:6064:de9b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b4eca0f376sm1060403a12.26.2026.10.31.06.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 06:04:52 -0700 (PDT)
Date: Sat, 31 Oct 2026 14:03:54 +0100
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Brad Smith <brad@comstyle.com>
Cc: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/unit/test-qga: only run tests for commands the
 host provides
Message-ID: <auXnOpeNx5eToSWA@tulp>
References: <auUjhZW4dqR63oA3@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auUjhZW4dqR63oA3@humpty.home.comstyle.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  Brad Smith wrote:

> tests/unit/test-qga: only run tests for commands the host provides
> 
> guest-fsfreeze-status is only implemented when CONFIG_FSFREEZE is
> set (Linux and FreeBSD), and guest-get-users is only built on POSIX
> hosts when HAVE_UTMPX is set, so neither command exists on hosts such
> as OpenBSD. Only build and register these tests where the commands
> are available.

Does that also need something like:

--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -170,7 +170,7 @@ if have_system
   tests += {'test-qdev': [qom, hwcore]}
 endif

-if have_ga and host_os in ['freebsd', 'linux']
+if have_ga and host_os in ['freebsd', 'linux', 'openbsd']
   tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
   test_deps += {'test-qga': qga}
 endif

Otherwise it's not clear how to spot these issues if the test never runs
on OpenBSD.

> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---
>  tests/unit/test-qga.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
> index b1c84c188b..ef796f2f7d 100644
> --- a/tests/unit/test-qga.c
> +++ b/tests/unit/test-qga.c
> @@ -787,6 +787,7 @@ static void test_qga_config(gconstpointer data)
>      g_free(env[0]);
>  }
>  
> +#ifdef CONFIG_FSFREEZE
>  static void test_qga_fsfreeze_status(gconstpointer fix)
>  {
>      const TestFixture *fixture = fix;
> @@ -800,6 +801,7 @@ static void test_qga_fsfreeze_status(gconstpointer fix)
>      status = qdict_get_try_str(ret, "return");
>      g_assert_cmpstr(status, ==, "thawed");
>  }
> +#endif
>  
>  static QDict *wait_for_guest_exec_completion(int fd, int64_t pid)
>  {
> @@ -1028,6 +1030,7 @@ static void test_qga_guest_get_timezone(gconstpointer fix)
>      g_assert(qdict_haskey(val, "offset"));
>  }
>  
> +#ifdef HAVE_UTMPX
>  static void test_qga_guest_get_users(gconstpointer fix)
>  {
>      const TestFixture *fixture = fix;
> @@ -1042,6 +1045,7 @@ static void test_qga_guest_get_users(gconstpointer fix)
>      val = qdict_get_qlist(ret, "return");
>      g_assert_nonnull(val);
>  }
> +#endif
>  
>  static void test_qga_guest_get_osinfo(gconstpointer data)
>  {
> @@ -1133,8 +1137,10 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/qga/invalid-oob", &fix, test_qga_invalid_oob);
>      g_test_add_data_func("/qga/invalid-cmd", &fix, test_qga_invalid_cmd);
>      g_test_add_data_func("/qga/invalid-args", &fix, test_qga_invalid_args);
> +#ifdef CONFIG_FSFREEZE
>      g_test_add_data_func("/qga/fsfreeze-status", &fix,
>                           test_qga_fsfreeze_status);
> +#endif
>  
>      g_test_add_data_func("/qga/blockedrpcs", NULL, test_qga_blockedrpcs);
>      g_test_add_data_func("/qga/allowedrpcs", NULL, test_qga_allowedrpcs);
> @@ -1152,8 +1158,10 @@ int main(int argc, char **argv)
>                           test_qga_guest_get_host_name);
>      g_test_add_data_func("/qga/guest-get-timezone", &fix,
>                           test_qga_guest_get_timezone);
> +#ifdef HAVE_UTMPX
>      g_test_add_data_func("/qga/guest-get-users", &fix,
>                           test_qga_guest_get_users);
> +#endif
>  
>      ret = g_test_run();
>  
> -- 
> 2.56.0
> 
> 

