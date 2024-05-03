Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFDFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s305x-0007Jx-Dd; Fri, 03 May 2024 17:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s305u-0007JZ-UZ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:05:27 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s305s-0003GA-4y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:05:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E4AA2079A;
 Fri,  3 May 2024 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714770322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FA+oSBebhGIc0eAolIhwy4tsrFKVk6iu1t/nD6VnTFk=;
 b=fODSTPORgsdgD6s689xTtf0nZe8CZOBZIDTXfIjTmhIH1BX00F2nlr5CFB7kq6LUCD4AxA
 WKRZKFYeGqJRNxHRXFpdzIXPis/fkvhDL2hNpkSnGEceK8Yt9zfgwzWbPsagTEJKUB+DDC
 KPn7BiYrPq3pUfDGXegs8vZabxK4fGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714770322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FA+oSBebhGIc0eAolIhwy4tsrFKVk6iu1t/nD6VnTFk=;
 b=VOZAVaveOSGGbDzicr0/S4GdStFpK4phhvbuRP1HCk3lXZYcyG6Deo31avs6A27g/i6p+K
 B9/jjh+0UDLXRIAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fODSTPOR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VOZAVave
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714770322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FA+oSBebhGIc0eAolIhwy4tsrFKVk6iu1t/nD6VnTFk=;
 b=fODSTPORgsdgD6s689xTtf0nZe8CZOBZIDTXfIjTmhIH1BX00F2nlr5CFB7kq6LUCD4AxA
 WKRZKFYeGqJRNxHRXFpdzIXPis/fkvhDL2hNpkSnGEceK8Yt9zfgwzWbPsagTEJKUB+DDC
 KPn7BiYrPq3pUfDGXegs8vZabxK4fGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714770322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FA+oSBebhGIc0eAolIhwy4tsrFKVk6iu1t/nD6VnTFk=;
 b=VOZAVaveOSGGbDzicr0/S4GdStFpK4phhvbuRP1HCk3lXZYcyG6Deo31avs6A27g/i6p+K
 B9/jjh+0UDLXRIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE62D13991;
 Fri,  3 May 2024 21:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JVnNIJFRNWabDQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 21:05:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 6/9] tests/qtest/migration: Add tests for file migration
 with direct-io
In-Reply-To: <ZjUvHjBOicENBbva@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-7-farosas@suse.de> <ZjUvHjBOicENBbva@x1n>
Date: Fri, 03 May 2024 18:05:19 -0300
Message-ID: <87v83umws0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E4AA2079A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Apr 26, 2024 at 11:20:39AM -0300, Fabiano Rosas wrote:
>> The tests are only allowed to run in systems that know about the
>> O_DIRECT flag and in filesystems which support it.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Mostly:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Two trivial comments below.
>
>> ---
>>  tests/qtest/migration-helpers.c | 42 +++++++++++++++++++++++++++++++++
>>  tests/qtest/migration-helpers.h |  1 +
>>  tests/qtest/migration-test.c    | 42 +++++++++++++++++++++++++++++++++
>>  3 files changed, 85 insertions(+)
>> 
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index ce6d6615b5..356cd4fa8c 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -473,3 +473,45 @@ void migration_test_add(const char *path, void (*fn)(void))
>>      qtest_add_data_func_full(path, test, migration_test_wrapper,
>>                               migration_test_destroy);
>>  }
>> +
>> +#ifdef O_DIRECT
>> +/*
>> + * Probe for O_DIRECT support on the filesystem. Since this is used
>> + * for tests, be conservative, if anything fails, assume it's
>> + * unsupported.
>> + */
>> +bool probe_o_direct_support(const char *tmpfs)
>> +{
>> +    g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
>> +    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
>> +    void *buf;
>> +    ssize_t ret, len;
>> +    uint64_t offset;
>> +
>> +    fd = open(filename, flags, 0660);
>> +    if (fd < 0) {
>> +        unlink(filename);
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * Assuming 4k should be enough to satisfy O_DIRECT alignment
>> +     * requirements. The migration code uses 1M to be conservative.
>> +     */
>> +    len = 0x100000;
>> +    offset = 0x100000;
>> +
>> +    buf = aligned_alloc(len, len);
>
> This is the first usage of aligned_alloc() in qemu.  IIUC it's just a newer
> posix_memalign(), which QEMU has one use of, and it's protected with:
>
> #if defined(CONFIG_POSIX_MEMALIGN)
>     int ret;
>     ret = posix_memalign(&ptr, alignment, size);
>     ...
> #endif
>
> Didn't check deeper.  Just keep this in mind if you see any compilation
> issues in future CIs, or simply switch to similar pattern.
>
>> +    g_assert(buf);
>> +
>> +    ret = pwrite(fd, buf, len, offset);
>> +    unlink(filename);
>> +    g_free(buf);
>> +
>> +    if (ret < 0) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +#endif
>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>> index 1339835698..d827e16145 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -54,5 +54,6 @@ char *find_common_machine_version(const char *mtype, const char *var1,
>>                                    const char *var2);
>>  char *resolve_machine_version(const char *alias, const char *var1,
>>                                const char *var2);
>> +bool probe_o_direct_support(const char *tmpfs);
>>  void migration_test_add(const char *path, void (*fn)(void));
>>  #endif /* MIGRATION_HELPERS_H */
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 7b177686b4..512b7ede8b 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -2295,6 +2295,43 @@ static void test_multifd_file_mapped_ram(void)
>>      test_file_common(&args, true);
>>  }
>>  
>> +#ifdef O_DIRECT
>> +static void *migrate_mapped_ram_dio_start(QTestState *from,
>> +                                                 QTestState *to)
>> +{
>> +    migrate_mapped_ram_start(from, to);
>
> This line seems redundant, migrate_multifd_mapped_ram_start() should cover that.
>

This is an artifact of another patch that adds direct-io + mapped-ram
without multifd. I'm bringing that back on v2. We were having a
discussion[1] about it in the libvirt mailing list. Having direct-io
even without multifd might still be useful for libvirt.

1- https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/K4BDDJDMJ22XMJEFAUE323H5S5E47VQX/

>> +    migrate_set_parameter_bool(from, "direct-io", true);
>> +    migrate_set_parameter_bool(to, "direct-io", true);
>> +
>> +    return NULL;
>> +}
>> +
>> +static void *migrate_multifd_mapped_ram_dio_start(QTestState *from,
>> +                                                 QTestState *to)
>> +{
>> +    migrate_multifd_mapped_ram_start(from, to);
>> +    return migrate_mapped_ram_dio_start(from, to);
>> +}
>> +
>> +static void test_multifd_file_mapped_ram_dio(void)
>> +{
>> +    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
>> +                                           FILE_TEST_FILENAME);
>> +    MigrateCommon args = {
>> +        .connect_uri = uri,
>> +        .listen_uri = "defer",
>> +        .start_hook = migrate_multifd_mapped_ram_dio_start,
>> +    };
>> +
>> +    if (!probe_o_direct_support(tmpfs)) {
>> +        g_test_skip("Filesystem does not support O_DIRECT");
>> +        return;
>> +    }
>> +
>> +    test_file_common(&args, true);
>> +}
>> +
>> +#endif /* O_DIRECT */
>>  
>>  static void test_precopy_tcp_plain(void)
>>  {
>> @@ -3719,6 +3756,11 @@ int main(int argc, char **argv)
>>      migration_test_add("/migration/multifd/file/mapped-ram/live",
>>                         test_multifd_file_mapped_ram_live);
>>  
>> +#ifdef O_DIRECT
>> +    migration_test_add("/migration/multifd/file/mapped-ram/dio",
>> +                       test_multifd_file_mapped_ram_dio);
>> +#endif
>> +
>>  #ifdef CONFIG_GNUTLS
>>      migration_test_add("/migration/precopy/unix/tls/psk",
>>                         test_precopy_unix_tls_psk);
>> -- 
>> 2.35.3
>> 

