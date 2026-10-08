Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC9DCA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEqJk-0007Ga-PP; Thu, 08 Oct 2026 11:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEqJg-0007Fw-LV
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEqJc-00026l-3a
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791474350;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2wHztVtXODTnu6HDmZAW+NJzAIHlV8k6cMkXYuYaTPg=;
 b=FJoCAolNytSw2Elb8hxUvcRqFuVLX0L5O5O5iHgA7Dt3rhfPajiYAhg6mOR9w0YGVdAf17
 m74qciXjYDe7IhMQG4tKq6DWfAVg0Bisi0gNnzkTZET191kbR3p5El50uHyjXXhfx4Cj88
 1gG0MjJMn4sGef+AhDa/NXlQCwspPBA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-wI_acoJuNV2P2p9EFtsuAg-1; Thu,
 08 Oct 2026 11:45:48 -0400
X-MC-Unique: wI_acoJuNV2P2p9EFtsuAg-1
X-Mimecast-MFC-AGG-ID: wI_acoJuNV2P2p9EFtsuAg_1791474347
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7F601831ED8; Thu,  8 Oct 2026 15:45:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3D4C418; Thu,  8 Oct 2026 15:45:44 +0000 (UTC)
Date: Thu, 8 Oct 2026 16:45:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, shentey@gmail.com,
 cohuck@redhat.com, farman@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v1] test/qtest: Remove s390x boot device support check in
 pxe-test.c
Message-ID: <ase6pruX6UM-umNQ@redhat.com>
References: <20261008153435.207538-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008153435.207538-1-zycai@linux.ibm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 08, 2026 at 11:34:35AM -0400, Zhuoying Cai wrote:
> The s390x PXE tests used `memmem` to probe the s390-ccw.img firmware
> for device support strings before running each test. MinGW-w64 does
> not provide `memmem`, breaking the MSYS2/GCC build.
> 
> Remove the check as a workaround.

Removing the testing on every platform due to a Windows limitation
is rather a big hammer. Why not wrap the code in  #ifndef WIN32   ?

> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Reported-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  tests/qtest/pxe-test.c | 97 +-----------------------------------------
>  1 file changed, 2 insertions(+), 95 deletions(-)
> 
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index 61c92a2df4..51e6bdac2a 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -26,7 +26,6 @@ typedef struct testdef {
>      const char *machine;    /* Machine type */
>      const char *model;      /* NIC device model */
>      const char *extra;      /* Any additional parameters */
> -    bool (*boot_dev_support)(void); /* optional: boot device support check */
>  } testdef_t;
>  
>  static testdef_t x86_tests[] = {
> @@ -59,91 +58,9 @@ static testdef_t ppc64_tests_slow[] = {
>      { NULL },
>  };
>  
> -static const char *s390_bios_load(gsize *len)
> -{
> -    static char *cached_contents;
> -    static gsize cached_len;
> -    const char *qemu_bin;
> -    g_autofree char *cmd = NULL;
> -    char dir[PATH_MAX];
> -    char *found = NULL;
> -    char *path = NULL;
> -    FILE *fp;
> -
> -    if (cached_contents) {
> -        g_test_message("Using cached bios contents");
> -        goto out;
> -    }
> -
> -    /* search the qemu binary's data directories for s390-ccw.img */
> -    qemu_bin = qtest_qemu_binary(NULL);
> -    cmd = g_strdup_printf("%s -L help", qemu_bin);
> -    fp = popen(cmd, "r");
> -
> -    if (!fp) {
> -        g_error("Failed to run '%s'", cmd);
> -    }
> -
> -    while (fgets(dir, sizeof(dir), fp) && !found) {
> -        dir[strcspn(dir, "\n")] = '\0';
> -        path = g_build_filename(dir, "s390-ccw.img", NULL);
> -        if (g_file_get_contents(path, &cached_contents, &cached_len, NULL)) {
> -            found = path;
> -        } else {
> -            g_free(path);
> -        }
> -    }
> -    pclose(fp);
> -
> -    if (!found) {
> -        g_error("s390-ccw.img not found");
> -    }
> -
> -    g_test_message("Loaded %s", found);
> -    g_free(found);
> -
> -out:
> -    *len = cached_len;
> -    return cached_contents;
> -}
> -
> -static bool s390_bios_has_string(const char *needle)
> -{
> -    const char *contents;
> -    gsize len;
> -    bool found;
> -
> -    contents = s390_bios_load(&len);
> -    found = memmem(contents, len, needle, strlen(needle)) != NULL;
> -
> -    g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");
> -    return found;
> -}
> -
> -static bool s390_bios_has_net_ccw(void)
> -{
> -    /*
> -     * Assume that netboot support always includes virtio-net-ccw support.
> -     * Check only that netboot code exists, rather than probing virtio-net-ccw
> -     * support directly.
> -     */
> -    return s390_bios_has_string("Network boot starting...");
> -}
> -
> -static bool s390_bios_has_net_pci(void)
> -{
> -    /*
> -     * Check for a string unique to virtio-net-pci boot support in the bios
> -     * to determine if the binary was built with support for this device.
> -     */
> -    return s390_bios_has_string("Setup failed for virtio-net-pci");
> -}
> -
>  static testdef_t s390x_tests[] = {
> -    { "s390-ccw-virtio", "virtio-net-ccw",
> -      .boot_dev_support = s390_bios_has_net_ccw },
> -    { "s390-ccw-virtio", "virtio-net-pci",
> -      .boot_dev_support = s390_bios_has_net_pci },
> +    { "s390-ccw-virtio", "virtio-net-ccw"},
> +    { "s390-ccw-virtio", "virtio-net-pci"},
>      { NULL },
>  };
>  
> @@ -174,11 +91,6 @@ static void test_pxe_ipv4(gconstpointer data)
>  {
>      const testdef_t *test = data;
>  
> -    if (test->boot_dev_support && !test->boot_dev_support()) {
> -        g_test_skip("The bios does not support booting this device");
> -        return;
> -    }
> -
>      test_pxe_one(test, false);
>  }
>  
> @@ -186,11 +98,6 @@ static void test_pxe_ipv6(gconstpointer data)
>  {
>      const testdef_t *test = data;
>  
> -    if (test->boot_dev_support && !test->boot_dev_support()) {
> -        g_test_skip("The bios does not support booting this device");
> -        return;
> -    }
> -
>      test_pxe_one(test, true);
>  }
>  
> -- 
> 2.56.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


