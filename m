Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0FFC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 21:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhYF-0001pL-I7; Mon, 27 May 2024 17:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhYE-0001pB-FI
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBhYC-00021r-RO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 17:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716843995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TyOiUAYMjUXV38DwnK7Fh3CUCrCM7uBFDKE4qL12XJw=;
 b=UPIleWJAg9JE8EvjbUTTZ2RfQgVn8Zb0DUDowgdptDlPAPhxLrpCV4pCP8H0GQU8jQL/W+
 gUvQb7oQI8tuk/n7OUucx+BJiYu3BBoLDAh0C3HDbrw4tWJK3cA3a+SFSvCjnvShpxuh44
 vLG7ddA3RFuaD8rpC80+prthfBmy4KM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-Kv8WnS62Om2xehBV-Opn0g-1; Mon, 27 May 2024 17:06:34 -0400
X-MC-Unique: Kv8WnS62Om2xehBV-Opn0g-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5b96a77ea14so51201eaf.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 14:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716843993; x=1717448793;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TyOiUAYMjUXV38DwnK7Fh3CUCrCM7uBFDKE4qL12XJw=;
 b=CTqPUrY5v54Ts3lxPCy0INxqGR4eYW0njzWriRYxrztLTZR0mTFKHFTthcDui2iA5Z
 K18KJx7yzzWKhypp6CwJxZg5HYeyXFuo6JKUWaqwffeQFD3iNpwBwmhJ98ukev8KSeQU
 5rIpamm9rmJVEfvaDcSrhfD/lRfKWyyzruBj2c2+Ktkxf4d0kkRpT4SuC/R++lj5tMWj
 OgL9J0YlkVN6Jkbhbaq46Z/M8DUQiXlXWXs3Dvrz+59L+8L+ZYWxUflSY8o+YajJ+ido
 vDtI9BhWzm5K0ZV6QKqDM4j9fgXe1LLHO7/oiuPFW5LCNGZllWlaebvq7vFDyPVojU84
 DF3w==
X-Gm-Message-State: AOJu0Yx4wfc6IoMZV50cn6olhvkoFwbMdnky/WoSZNbRhGvnTxFcVfb2
 1lgH0THE7tIyjvAHD2wlX5jd+vfsKOa+7ZV8OcF/i4p4Zg0y9sgjbFSSOnGt+HmlgJuzO4ZYDNo
 lZtDUrNTy+Yhn2DcOaNZyQJrgc596JcIfp++ICzXyxJjjRqNdqvuc
X-Received: by 2002:a05:6808:2108:b0:3c7:528b:12ce with SMTP id
 5614622812f47-3d1a7648067mr12064087b6e.3.1716843993093; 
 Mon, 27 May 2024 14:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtnMPyN/NJo6akkJVO4DejglFKiBCrbkFfX44m4qgFOc3qMsd1RvCwdZ1p9/VrdhIv/+S/sQ==
X-Received: by 2002:a05:6808:2108:b0:3c7:528b:12ce with SMTP id
 5614622812f47-3d1a7648067mr12064046b6e.3.1716843992422; 
 Mon, 27 May 2024 14:06:32 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad8fa000eesm2247116d6.1.2024.05.27.14.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 14:06:31 -0700 (PDT)
Date: Mon, 27 May 2024 17:06:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 2/4] tests/qtest/migration: Add a test that runs
 vmstate-static-checker
Message-ID: <ZlT11c-9IDwVfm52@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523201922.28007-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 23, 2024 at 05:19:20PM -0300, Fabiano Rosas wrote:
> We have the vmstate-static-checker script that takes the output of:
> '$QEMU -M $machine -dump-vmstate' for two different QEMU versions and
> compares them to check for compatibility breakages. This is just too
> simple and useful for us to pass on it. Add a test that runs the
> script.
> 
> Since this needs to use two different QEMU versions, the test is
> skipped if only one QEMU is provided. The infrastructure for passing
> more than one binary is already in place:
> 
> $ PYTHON=$(which python3.11) \
>  QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-x86_64 \
>  QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>  ./tests/qtest/migration-test -p /x86_64/migration/vmstate-checker-script
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> some code duplication for now, just so we can reason about this
> without too much noise
> ---
>  tests/qtest/migration-test.c | 82 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e8d3555f56..2253e0fc5b 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -63,6 +63,7 @@ static QTestMigrationState dst_state;
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>  
>  #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
> +#define VMSTATE_CHECKER_SCRIPT "scripts/vmstate-static-checker.py"
>  
>  #define QEMU_VM_FILE_MAGIC 0x5145564d
>  #define FILE_TEST_FILENAME "migfile"
> @@ -1611,6 +1612,85 @@ static void test_analyze_script(void)
>      test_migrate_end(from, to, false);
>      cleanup("migfile");
>  }
> +
> +static void test_vmstate_checker_script(void)
> +{
> +    g_autofree gchar *cmd_src = NULL;
> +    g_autofree gchar *cmd_dst = NULL;
> +    g_autofree gchar *vmstate_src = NULL;
> +    g_autofree gchar *vmstate_dst = NULL;
> +    const char *machine_alias, *machine_opts = "";
> +    g_autofree char *machine = NULL;
> +    const char *arch = qtest_get_arch();
> +    int pid, wstatus;
> +    const char *python = g_getenv("PYTHON");
> +
> +    if (!getenv(QEMU_ENV_SRC) && !getenv(QEMU_ENV_DST)) {
> +        g_test_skip("Test needs two different QEMU versions");
> +        return;
> +    }
> +
> +    if (!python) {
> +        g_test_skip("PYTHON variable not set");
> +        return;
> +    }
> +
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        if (g_str_equal(arch, "i386")) {
> +            machine_alias = "pc";
> +        } else {
> +            machine_alias = "q35";
> +        }
> +    } else if (g_str_equal(arch, "s390x")) {
> +        machine_alias = "s390-ccw-virtio";
> +    } else if (strcmp(arch, "ppc64") == 0) {
> +        machine_alias = "pseries";
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        machine_alias = "virt";
> +    } else {
> +        g_assert_not_reached();
> +    }
> +
> +    if (!qtest_has_machine(machine_alias)) {
> +        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
> +        g_test_skip(msg);
> +        return;
> +    }
> +
> +    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
> +                                      QEMU_ENV_DST);
> +
> +    vmstate_src = g_strdup_printf("%s/vmstate-src", tmpfs);
> +    vmstate_dst = g_strdup_printf("%s/vmstate-dst", tmpfs);
> +
> +    cmd_dst = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
> +                              machine, machine_opts, vmstate_dst);
> +    cmd_src = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
> +                              machine, machine_opts, vmstate_src);
> +
> +    qtest_init_with_env_no_handshake(QEMU_ENV_SRC, cmd_src);
> +    qtest_init_with_env_no_handshake(QEMU_ENV_DST, cmd_dst);
> +
> +    pid = fork();
> +    if (!pid) {
> +        close(1);
> +        open("/dev/null", O_WRONLY);
> +        execl(python, python, VMSTATE_CHECKER_SCRIPT,
> +              "-s", vmstate_src,
> +              "-d", vmstate_dst,
> +              NULL);
> +        g_assert_not_reached();
> +    }
> +
> +    g_assert(waitpid(pid, &wstatus, 0) == pid);
> +    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
> +        g_test_message("Failed to run vmstate-static-checker.py");
> +        g_test_fail();
> +    }
> +
> +    cleanup("vmstate-src");
> +    cleanup("vmstate-dst");
> +}

Did I ask before on whether this can be written without C?

I think this and also the analyze-script are more suitable to be written in
other ways, e.g., bash or python, no?

>  #endif
>  
>  static void test_precopy_common(MigrateCommon *args)
> @@ -3495,6 +3575,8 @@ int main(int argc, char **argv)
>  #ifndef _WIN32
>      if (!g_str_equal(arch, "s390x")) {
>          migration_test_add("/migration/analyze-script", test_analyze_script);
> +        migration_test_add("/migration/vmstate-checker-script",
> +                           test_vmstate_checker_script);
>      }
>  #endif
>      migration_test_add("/migration/precopy/unix/plain",
> -- 
> 2.35.3
> 

-- 
Peter Xu


