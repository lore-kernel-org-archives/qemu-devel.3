Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44558C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkWH0-00074r-LK; Tue, 18 Feb 2025 17:41:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkWGy-00074X-LM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:41:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkWGv-00044s-SM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739918456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yqk/ct2BVFMPxqKQ6Y+q6JgA+3IxPP1JtPMvq+eSyc8=;
 b=blRpWhfr8iza/LGpIW5AM16bVSvYdNCH9uDMs6lXjbD7fIc0oYlm/5QdP7AjsSlplcvLPd
 rAqS6QT8N+Kc2bme1fgOO/9h/OuTo4GRLQdDhKxbIF77PR+nzXZbqZl1YouPJJbYwRtFLc
 O5E9T5YObkwpFDhesDKS4A8CGecUAXw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-TBiFkPYGOpK_rpvZsl77og-1; Tue, 18 Feb 2025 17:40:52 -0500
X-MC-Unique: TBiFkPYGOpK_rpvZsl77og-1
X-Mimecast-MFC-AGG-ID: TBiFkPYGOpK_rpvZsl77og_1739918452
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e66249f058so202834796d6.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:40:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739918452; x=1740523252;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yqk/ct2BVFMPxqKQ6Y+q6JgA+3IxPP1JtPMvq+eSyc8=;
 b=B6T06ILdcvij6oWrF7cx3VCIuoCQMU7i31xV9eTCjprI0O+K6NufgIA9NzKiDDK60A
 khJVkrYluhYzv8PzigiytKf4pIbwExNgE94VKIbX55Gqeo26cu+FnWC2f5wvsrAYl28T
 2D5ih7EgdwkfWNM8difPo6wbttmgtEsaFzwHvkYq69um+e3YL4W54eHBacehvymThoD1
 RB/2Vx/qYV+Kb7A4w3evxGco+pZDNi7/SgFFh1ntcl1g1zRDLBRGLljJiWwypm35rEzv
 7Tnlf/ZHgAl/4qKgMvcnBNAcmdvr5BfuyMIp5va+6+0j8JzNabnnojqP1x3b/7zApKHN
 xDHw==
X-Gm-Message-State: AOJu0YzlsEu0dX7k7zF7VeIxeggAFapzJ3gQHo2cNLU5qxiq5of73yTT
 /uJvEpVUAU62pZvjXc9uENCrw8nxy+nGn4LCZPRfS6UUl8gW0QGVkejg+TZDBLlp5CglB2h7ocT
 6hEcCaRDI1Dnh30GJlE6qdRMNu79LV91NEyV99zjH4Y/eCgwyV3i/
X-Gm-Gg: ASbGncs8U+0J7y+UEIJcPRVl5QdIm4VEL5QNfFOBWlOU8UbDKH7rFjh0gsFtblwsaBf
 cWcPBtv/9w6Sk+N5Otfm3jQgFOeWOAURG5K1SSwl530/TEl3Hg89i/3t17i2ZKqWkz4VEpVR8Ru
 Mttm6nPHX5G647wh3UZ8+G7hI0M6+LuautTXhfC0X+MvOv+OjzM7DMjHAzq6oAL8hRcOOOTOZWK
 ANRKIwXDhRlNoVf5JvGrhf+5EM6mOhaEyZVScxG4QTMyVRQ4GynNdfcshM=
X-Received: by 2002:ad4:5de8:0:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6e66ccbc0e0mr241910216d6.15.1739918452281; 
 Tue, 18 Feb 2025 14:40:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBCxdCXzdZownJcxNIB32Gbi0iX2EuyoKI1kKKkbbSwN2oahAd0X/Mf3iiUuGaQrx5cw63gg==
X-Received: by 2002:ad4:5de8:0:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6e66ccbc0e0mr241910036d6.15.1739918452006; 
 Tue, 18 Feb 2025 14:40:52 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e65dce9f9csm67904476d6.104.2025.02.18.14.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 14:40:51 -0800 (PST)
Date: Tue, 18 Feb 2025 17:40:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Li Zhijian via <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Message-ID: <Z7UMcIQ4QrcXqwK3@x1.local>
References: <20250218074345.638203-1-lizhijian@fujitsu.com>
 <20250218074345.638203-2-lizhijian@fujitsu.com>
 <87zfij7yob.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfij7yob.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 18, 2025 at 06:03:48PM -0300, Fabiano Rosas wrote:
> Li Zhijian via <qemu-devel@nongnu.org> writes:
> 
> > This qtest requirs there is RXE link in the host.
> >
> > Here is an example to show how to add this RXE link:
> > $ ./new-rdma-link.sh
> > 192.168.22.93
> >
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> > The RDMA migration was broken again...due to lack of sufficient test/qtest.
> >
> > It's urgly to add and execute a script to establish an RDMA link in
> > the C program. If anyone has a better suggestion, please let me know.
> >
> > $ cat ./new-rdma-link.sh
> > get_ipv4_addr() {
> >         ip -4 -o addr show dev "$1" |
> >                 sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
> > }
> >
> > has_soft_rdma() {
> >         rdma link | grep -q " netdev $1[[:blank:]]*\$"
> > }
> >
> > start_soft_rdma() {
> >         local type
> >
> >         modprobe rdma_rxe || return $?
> >         type=rxe
> >         (
> >                 cd /sys/class/net &&
> >                         for i in *; do
> >                                 [ -e "$i" ] || continue
> >                                 [ "$i" = "lo" ] && continue
> >                                 [ "$(<"$i/addr_len")" = 6 ] || continue
> >                                 [ "$(<"$i/carrier")" = 1 ] || continue
> >                                 has_soft_rdma "$i" && break
> >                                 rdma link add "${i}_$type" type $type netdev "$i" && break
> >                         done
> >                 has_soft_rdma "$i" && echo $i
> >         )
> >
> > }
> >
> > rxe_link=$(start_soft_rdma)
> > [[ "$rxe_link" ]] && get_ipv4_addr $rxe_link
> >
> > Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> > ---
> >  tests/qtest/migration/new-rdma-link.sh |  34 ++++++++
> >  tests/qtest/migration/precopy-tests.c  | 103 +++++++++++++++++++++++++
> >  2 files changed, 137 insertions(+)
> >  create mode 100644 tests/qtest/migration/new-rdma-link.sh
> >
> > diff --git a/tests/qtest/migration/new-rdma-link.sh b/tests/qtest/migration/new-rdma-link.sh
> > new file mode 100644
> > index 00000000000..ca20594eaae
> > --- /dev/null
> > +++ b/tests/qtest/migration/new-rdma-link.sh
> > @@ -0,0 +1,34 @@
> > +#!/bin/bash
> > +
> > +# Copied from blktests
> > +get_ipv4_addr() {
> > +	ip -4 -o addr show dev "$1" |
> > +		sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p'
> > +}
> > +
> > +has_soft_rdma() {
> > +	rdma link | grep -q " netdev $1[[:blank:]]*\$"
> > +}
> > +
> > +start_soft_rdma() {
> > +	local type
> > +
> > +	modprobe rdma_rxe || return $?
> > +	type=rxe
> > +	(
> > +		cd /sys/class/net &&
> > +			for i in *; do
> > +				[ -e "$i" ] || continue
> > +				[ "$i" = "lo" ] && continue
> > +				[ "$(<"$i/addr_len")" = 6 ] || continue
> > +				[ "$(<"$i/carrier")" = 1 ] || continue
> > +				has_soft_rdma "$i" && break
> > +				rdma link add "${i}_$type" type $type netdev "$i" && break
> > +			done
> > +		has_soft_rdma "$i" && echo $i
> > +	)
> > +
> > +}
> > +
> > +rxe_link=$(start_soft_rdma)
> > +[[ "$rxe_link" ]] && get_ipv4_addr $rxe_link
> > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> > index 162fa695318..d2a1c9c9438 100644
> > --- a/tests/qtest/migration/precopy-tests.c
> > +++ b/tests/qtest/migration/precopy-tests.c
> > @@ -98,6 +98,105 @@ static void test_precopy_unix_dirty_ring(void)
> >      test_precopy_common(&args);
> >  }
> >  
> > +static int new_rdma_link(char *buffer) {
> > +    // Copied from blktests
> > +    const char *script =
> > +        "#!/bin/bash\n"
> > +        "\n"
> > +        "get_ipv4_addr() {\n"
> > +        "    ip -4 -o addr show dev \"$1\" |\n"
> > +        "    sed -n 's/.*[[:blank:]]inet[[:blank:]]*\\([^[:blank:]/]*\\).*/\\1/p'\n"
> > +        "}\n"
> > +        "\n"
> > +        "has_soft_rdma() {\n"
> > +        "    rdma link | grep -q \" netdev $1[[:blank:]]*\\$\"\n"
> > +        "}\n"
> > +        "\n"
> > +        "start_soft_rdma() {\n"
> > +        "    local type\n"
> > +        "\n"
> > +        "    modprobe rdma_rxe || return $?\n"
> > +        "    type=rxe\n"
> > +        "    (\n"
> > +        "        cd /sys/class/net &&\n"
> > +        "        for i in *; do\n"
> > +        "            [ -e \"$i\" ] || continue\n"
> > +        "            [ \"$i\" = \"lo\" ] && continue\n"
> > +        "            [ \"$(<$i/addr_len)\" = 6 ] || continue\n"
> > +        "            [ \"$(<$i/carrier)\" = 1 ] || continue\n"
> > +        "            has_soft_rdma \"$i\" && break\n"
> > +        "            rdma link add \"${i}_$type\" type $type netdev \"$i\" && break\n"
> > +        "        done\n"
> > +        "        has_soft_rdma \"$i\" && echo $i\n"
> > +        "    )\n"
> > +        "}\n"
> > +        "\n"
> > +        "rxe_link=$(start_soft_rdma)\n"
> > +        "[[ \"$rxe_link\" ]] && get_ipv4_addr $rxe_link\n";
> > +
> > +    char script_filename[] = "/tmp/temp_scriptXXXXXX";
> > +    int fd = mkstemp(script_filename);
> > +    if (fd == -1) {
> > +        perror("Failed to create temporary file");
> > +        return 1;
> > +    }
> > +
> > +    FILE *fp = fdopen(fd, "w");
> > +    if (fp == NULL) {
> > +        perror("Failed to open file stream");
> > +        close(fd);
> > +        return 1;
> > +    }
> > +    fprintf(fp, "%s", script);
> > +    fclose(fp);
> > +
> > +    if (chmod(script_filename, 0700) == -1) {
> > +        perror("Failed to set execute permission");
> > +        return 1;
> > +    }
> > +
> > +    FILE *pipe = popen(script_filename, "r");
> > +    if (pipe == NULL) {
> > +        perror("Failed to run script");
> > +        return 1;
> > +    }
> > +
> > +    int idx = 0;
> > +    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
> > +        idx += strlen(buffer);
> > +    }
> > +    if (buffer[idx - 1] == '\n')
> > +        buffer[idx - 1] = 0;
> > +
> > +    int status = pclose(pipe);
> > +    if (status == -1) {
> > +        perror("Error reported by pclose()");
> > +    } else if (!WIFEXITED(status)) {
> > +        printf("Script did not terminate normally\n");
> > +    }
> > +
> > +    remove(script_filename);

The script can be put separately instead if hard-coded here, right?

> > +
> > +    return 0;
> > +}
> > +
> > +static void test_precopy_rdma_plain(void)
> > +{
> > +    char buffer[128] = {};
> > +
> > +    if (new_rdma_link(buffer))
> > +        return;
> > +
> > +    g_autofree char *uri = g_strdup_printf("rdma:%s:7777", buffer);
> > +
> > +    MigrateCommon args = {
> > +        .listen_uri = uri,
> > +        .connect_uri = uri,
> > +    };
> > +
> > +    test_precopy_common(&args);
> > +}
> > +
> >  static void test_precopy_tcp_plain(void)
> >  {
> >      MigrateCommon args = {
> > @@ -968,6 +1067,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
> >                         test_multifd_tcp_uri_none);
> >      migration_test_add("/migration/multifd/tcp/plain/cancel",
> >                         test_multifd_tcp_cancel);
> > +#ifdef CONFIG_RDMA
> > +    migration_test_add("/migration/precopy/rdma/plain",
> > +                       test_precopy_rdma_plain);
> > +#endif
> >  }
> >  
> >  void migration_test_add_precopy(MigrationTestEnv *env)
> 
> Thanks, that's definitely better than nothing. I'll experiment with this
> locally, see if I can at least run it before sending a pull request.

With your newly added --full, IIUC we can add whatever we want there.
E.g. we can add --rdma and iff specified, migration-test adds the rdma test.

Or.. skip the test when the rdma link isn't available.

If we could separate the script into a file, it'll be better.  We could
create scripts/migration dir and put all migration scripts over there, then
in the test it tries to detect rdma link and fetch the ip only (aka, we'd
better keep the test itself not rely on root permission..).

-- 
Peter Xu


