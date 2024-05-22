Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F168EC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 14:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9mgz-0005LU-2i; Wed, 22 May 2024 10:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9mgw-0005KI-TO
 for qemu-devel@nongnu.org; Wed, 22 May 2024 10:11:42 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9mgp-0008ND-HW
 for qemu-devel@nongnu.org; Wed, 22 May 2024 10:11:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57822392a0dso2819772a12.0
 for <qemu-devel@nongnu.org>; Wed, 22 May 2024 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716387093; x=1716991893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w9t9pAXlEUSybFvT6y8bHMTW3xqdPXxRIwp27IwWGQw=;
 b=tF8gnhxbwJI+taDkg5DYxJrZSs9X/QtHAQQlTcLn2UMW/LnEi45Pa5KY7Jrov4xsxV
 uAuLpkPdAIGUPCzTedFoGgk7HlrHshXTWsrnV6OStR/PiXNVsEig6ya5Rr+o25LMiOAR
 Cs7ocVa77Ns2WJpCzE+NOsyvzBPw+kOnw7IpQfrKGTxWgQZ3iHb8i2CYySvmOkF1GBan
 niTfHsmwIDhazwcNUkjV5SpXtakyvCmZg0BW8SVELqhEiLcygteIURMnA2kLBLCy0JW5
 P7flW6UzCn3mPthUTpFb28Nt43yF5jWDy5XLTcC/oif0TohLdToXmBL6xWgiaMUpyUQy
 CAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716387093; x=1716991893;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9t9pAXlEUSybFvT6y8bHMTW3xqdPXxRIwp27IwWGQw=;
 b=Ok3cuXK9HaZORgE6PfCbI/7oi1qccAT4aICI9pPYIyFBDXlZS+QdV0G401tW8Uke53
 ZzZ+Qin2FTkeK8XQS76ojG0HIFfkk55BAXEq67a6JhoDi5peCJk+r55v8o3lZRecvXqh
 V+/pxlRH5sRJHErdgXVA4R6XWbUbZ+WKb1W3i2Xy9yijFK6WYuaWWplEmD6Z+HlQ/MVl
 w3KUCaVcXEwy1oDmudypA9CBJPdyPAxUzcL/C3KhtvydtSjOJRtSOToD/l2acgnWWEhW
 IJT2E0HHGTzCpScc2fUBjmo4eu1DemJ9G74nwrg1wF7e5M+v6VmiqX2Bw+EaOheaG1Il
 S97Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPy3bA1E1JXmlduUWD0Lyao+Eg6+blo2bx3OOpriJz+d7fREXa4KzDx+Vy1Uzrc2/b2DjKRuWntLjzgW7+pdJ7CMUs4mg=
X-Gm-Message-State: AOJu0YwJPijS3O7JdDH/F2q9hY0MgU5q5c1BvXvBkM2HN8xMC6iQqgJH
 rzIGMOJbxkTRwXWJxnG45cfKhg6kEwXdD98Yde7w+d4cRX/hipDwRjXy5zAiIcI=
X-Google-Smtp-Source: AGHT+IF0fWehctgHQH7B/1et9lV0Yr1VC1F0CjzRnXbAwwjLmAB2JbpkhLcLMFCOlfhWXO+AVeblCg==
X-Received: by 2002:a17:906:c799:b0:a59:c319:f1e3 with SMTP id
 a640c23a62f3a-a62280b08cfmr126924266b.12.1716387092437; 
 Wed, 22 May 2024 07:11:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5d10b3ef82sm717534566b.158.2024.05.22.07.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 07:11:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5BF4A5F78B;
 Wed, 22 May 2024 15:11:31 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: Juan Quintela <quintela@redhat.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <87bk4zjpt2.fsf@suse.de> (Fabiano Rosas's message of "Tue, 21 May
 2024 09:46:17 -0300")
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-11-quintela@redhat.com>
 <87wmnnic86.fsf@draig.linaro.org> <87bk4zjpt2.fsf@suse.de>
Date: Wed, 22 May 2024 15:11:31 +0100
Message-ID: <87msoigcmk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> From: Fabiano Rosas <farosas@suse.de>
>>>
>>> Add a smoke test that migrates to a file and gives it to the
>>> script. It should catch the most annoying errors such as changes in
>>> the ram flags.
>>>
>>> After code has been merged it becomes way harder to figure out what is
>>> causing the script to fail, the person making the change is the most
>>> likely to know right away what the problem is.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> Message-ID: <20231009184326.15777-7-farosas@suse.de>
>>
>> I bisected the failures I'm seeing on s390x to the introduction of this
>> script. I don't know if its simply a timeout on a relatively slow VM:
>
> What's the range of your bisect? That test has been disabled and then
> reenabled on s390x. It could be tripping the bisect.
>
> 04131e0009 ("tests/qtest/migration-test: Disable the analyze-migration.py=
 test on s390x")
> 81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for
> s390x")

I ran between v8.1.0 and master.

But it is still failing @ HEAD 01782d6b294f95bcde334386f0aaac593cd28c0d
as you can see from the run I did at the end.

>
> I don't think that test itself could be timing out. It's a very simple
> test. It runs a migration and then uses the output to validate the
> script.
>
> I don't have a Z machine at hand and the migration tests only run with
> KVM for s390x, so it would be useful to take a look at meson's
> testlog.txt so we can see which test is failing and hopefully in what
> way it is failing.
>
> If you're up for it, running this in a loop is usually the best way to
> catch any intermittent issues:
>
> QTEST_QEMU_BINARY=3D./qemu-system-x86_64 ./tests/qtest/migration-test
>
> And once you figure out which test, there's this monstrosity:
>
> QTEST_QEMU_BINARY=3D'gdb -q --ex "set pagination off"          \
>                           --ex "set print thread-events off" \
>                           --ex "handle SIGUSR1 noprint"      \
>                           --ex "handle SIGPIPE noprint"      \
>                           --ex "run" --ex "quit \$_exitcode" \
>                           --args ./qemu-system-x86_64'       \
>                           gdb -q --ex "set prompt (qtest) "  \
>                           --ex "handle SIGPIPE noprint"      \
>                           --args ./tests/qtest/migration-test -p /x86_64/=
migration/<some>/<test>
>
>> Summary of Failures:
>>
>>  36/546 qemu:qtest+qtest-s390x / qtest-s390x/migration-test             =
          ERROR          93.51s   killed by signal 6 SIGABRT
>>
>> It seems to be unstable as we pass sometimes:
>>
>> 11:26:42 [ajb@qemu01:~/l/q/b/system] master|=E2=80=A6 + ./pyvenv/bin/mes=
on test --repeat 100 qtest-s390x/migration-test
>> ninja: Entering directory `/home/ajb/lsrc/qemu.git/builds/system'
>> [1/9] Generating qemu-version.h with a custom command (wrapped by meson =
to capture output)
>>   1/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERR=
OR          251.98s   killed by signal 6 SIGABRT
>>>>> MALLOC_PERTURB_=3D9
>>>>> PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyvenv/bin/python3
>>>>> G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-vmstate-daemo=
n.sh
>>>>> QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D./qemu-img
>>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daem=
on
>>>>> /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test
>>>>> --tap -k
>>
>>   2/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERR=
OR          258.71s   killed by signal 6 SIGABRT
>>>>> PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyvenv/bin/python3
>>>>> MALLOC_PERTURB_=3D205
>>>>> G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-vmstate-daemo=
n.sh
>>>>> QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D./qemu-img
>>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daem=
on
>>>>> /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test
>>>>> --tap -k
>>
>>   3/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK =
            302.53s   46 subtests passed
>>   4/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK =
            319.56s   46 subtests passed
>>   5/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK =
            320.11s   46 subtests passed
>>   6/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK =
            328.40s   46 subtests passed
>>
>> Ok:                 4=20=20=20
>> Expected Fail:      0=20=20=20
>> Fail:               2=20=20=20
>> Unexpected Pass:    0=20=20=20
>> Skipped:            0=20=20=20
>> Timeout:            0=20=20=20
>>
>>> ---
>>>  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>>>  tests/qtest/meson.build      |  2 ++
>>>  2 files changed, 62 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index 8eb2053dbb..cef5081f8c 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -66,6 +66,8 @@ static bool got_dst_resume;
>>>   */
>>>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>>>=20=20
>>> +#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
>>> +
>>>  #if defined(__linux__)
>>>  #include <sys/syscall.h>
>>>  #include <sys/vfs.h>
>>> @@ -1501,6 +1503,61 @@ static void test_baddest(void)
>>>      test_migrate_end(from, to, false);
>>>  }
>>>=20=20
>>> +#ifndef _WIN32
>>> +static void test_analyze_script(void)
>>> +{
>>> +    MigrateStart args =3D {
>>> +        .opts_source =3D "-uuid 11111111-1111-1111-1111-111111111111",
>>> +    };
>>> +    QTestState *from, *to;
>>> +    g_autofree char *uri =3D NULL;
>>> +    g_autofree char *file =3D NULL;
>>> +    int pid, wstatus;
>>> +    const char *python =3D g_getenv("PYTHON");
>>> +
>>> +    if (!python) {
>>> +        g_test_skip("PYTHON variable not set");
>>> +        return;
>>> +    }
>>> +
>>> +    /* dummy url */
>>> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
>>> +        return;
>>> +    }
>>> +
>>> +    /*
>>> +     * Setting these two capabilities causes the "configuration"
>>> +     * vmstate to include subsections for them. The script needs to
>>> +     * parse those subsections properly.
>>> +     */
>>> +    migrate_set_capability(from, "validate-uuid", true);
>>> +    migrate_set_capability(from, "x-ignore-shared", true);
>>> +
>>> +    file =3D g_strdup_printf("%s/migfile", tmpfs);
>>> +    uri =3D g_strdup_printf("exec:cat > %s", file);
>>> +
>>> +    migrate_ensure_converge(from);
>>> +    migrate_qmp(from, uri, "{}");
>>> +    wait_for_migration_complete(from);
>>> +
>>> +    pid =3D fork();
>>> +    if (!pid) {
>>> +        close(1);
>>> +        open("/dev/null", O_WRONLY);
>>> +        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
>>> +        g_assert_not_reached();
>>> +    }
>>> +
>>> +    g_assert(waitpid(pid, &wstatus, 0) =3D=3D pid);
>>> +    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
>>> +        g_test_message("Failed to analyze the migration stream");
>>> +        g_test_fail();
>>> +    }
>>> +    test_migrate_end(from, to, false);
>>> +    cleanup("migfile");
>>> +}
>>> +#endif
>>> +
>>>  static void test_precopy_common(MigrateCommon *args)
>>>  {
>>>      QTestState *from, *to;
>>> @@ -2837,6 +2894,9 @@ int main(int argc, char **argv)
>>>      }
>>>=20=20
>>>      qtest_add_func("/migration/bad_dest", test_baddest);
>>> +#ifndef _WIN32
>>> +    qtest_add_func("/migration/analyze-script", test_analyze_script);
>>> +#endif
>>>      qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_=
plain);
>>>      qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix=
_xbzrle);
>>>      /*
>>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>>> index 66795cfcd2..d6022ebd64 100644
>>> --- a/tests/qtest/meson.build
>>> +++ b/tests/qtest/meson.build
>>> @@ -357,6 +357,8 @@ foreach dir : target_dirs
>>>      test_deps +=3D [qsd]
>>>    endif
>>>=20=20
>>> +  qtest_env.set('PYTHON', python.full_path())
>>> +
>>>    foreach test : target_qtests
>>>      # Executables are shared across targets, declare them only the fir=
st time we
>>>      # encounter them

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

