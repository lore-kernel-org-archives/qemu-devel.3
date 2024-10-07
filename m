Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75914CFB43C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrdO-0000xq-3R; Mon, 07 Oct 2024 13:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxrdL-0000xZ-Os
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:34:59 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sxrdJ-00077v-OA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:34:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71df7632055so1929744b3a.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1728322496; x=1728927296;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5yHQ4caornT76OWtbzxpQdb8fS5agDCbCCVJg+7gYI4=;
 b=B8h+0SV/qKz3IMXT1vxRyhDyxrN5iOlUD4ihsyqtyssl7khcWaSdqp+YTbXgR+XfZB
 dgYR7tOqnHE0eSRgkrzttlzuI43jlK636tBZICzsy2xnyBEhJRsSWbdcbM6Mehe+E5Vf
 2yvbA7PZb8pVnGxVIRlE42uWmVyQmqhGxKwiWIL5AEZpGT5CtLzF4umzWcI1F5l+siSL
 7165jDWAMG9bk+ExbP759I50N6eubITXMrn0dah6XIbtvMmHSRYVp4lPJL0E4Oh+L/Hr
 Rzl3dg/lvy8mZaV30rRMEr/L9sRoyUrxQXB0G6D9dWIf0aVYkpp82Cksmj42TOslkaN0
 qUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728322496; x=1728927296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5yHQ4caornT76OWtbzxpQdb8fS5agDCbCCVJg+7gYI4=;
 b=ae7Y2YzSyyXobeNbgl7XbmRkQnpLflKm3yxfSc/XLHcVNxlpsUQNVIPH57oJ+YG100
 xgV76/WZRwwHarcqRXFLWnd6WohqV1VtWCFyTgJZVZ0EMxZun3S/CaRaW/62OZ7LmVEa
 PQTxMMkS1zW7kTCxxwOHOwrXPq/dMFGCxh/z8qbZ4VsqT9RfxZyjfrfFkTqv7F2cN+xD
 lrsrPWK6qx8+lQmVlKr6PEvW2a8YQniUXCq2Kt1hb0NBScMtKmaeQvX6yYftK5OkTJ8T
 2pIKLgpsFCWvArK345rCfliOlVZj8LvXjno2V5UWlIYMjcoqc7I9HVLv6E8Uc9V0sVfR
 v3PA==
X-Gm-Message-State: AOJu0YwKAqzG16J3IA5os3oEdPrXeIjWfaxNYA35663KFafHac765oy/
 Dcomr0vc+CE+3O2whWtW/qXrL+Yjhx2S6b7Dygu2fOlqiR22CNE/lfp4Q2CWksg=
X-Google-Smtp-Source: AGHT+IFN6uM7bixVogBw9vdxu2JqB1CvnqVVwMdmElxwKsC7CU1XXroFsZWqpoV4o+yfhhfrlipwqA==
X-Received: by 2002:a05:6a20:c52f:b0:1d4:e665:11f8 with SMTP id
 adf61e73a8af0-1d6dfa36966mr14197438637.18.1728322496167; 
 Mon, 07 Oct 2024 10:34:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e9f6c376cfsm4440867a12.61.2024.10.07.10.34.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 10:34:55 -0700 (PDT)
Message-ID: <05115d13-45b4-455a-9c56-1836c26eb1b3@daynix.com>
Date: Tue, 8 Oct 2024 02:34:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] tests: add basic -display dbus Map.Unix test
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-17-marcandre.lureau@redhat.com>
 <f0c03b18-387f-450c-b1c5-33cf51b83445@daynix.com>
 <CAMxuvaz0VneZHRmDnmJNZvaNoS9V28ZDLNWt33WYgXVpO9NDHw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAMxuvaz0VneZHRmDnmJNZvaNoS9V28ZDLNWt33WYgXVpO9NDHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/07 21:42, Marc-André Lureau wrote:
> Hi
> 
> On Sat, Oct 5, 2024 at 12:32 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Only check we eventually get a shared memory scanout.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    tests/qtest/dbus-display-test.c | 64 ++++++++++++++++++++++++++++++---
>>>    1 file changed, 59 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
>>> index 0390bdcb41..ac92cb00d4 100644
>>> --- a/tests/qtest/dbus-display-test.c
>>> +++ b/tests/qtest/dbus-display-test.c
>>> @@ -2,9 +2,12 @@
>>>    #include "qemu/sockets.h"
>>>    #include "qemu/dbus.h"
>>>    #include "qemu/sockets.h"
>>> +#include "glib.h"
>>> +#include "glibconfig.h"
>>>    #include <gio/gio.h>
>>>    #include <gio/gunixfdlist.h>
>>>    #include "libqtest.h"
>>> +#include <sys/mman.h>
>>>    #include "ui/dbus-display1.h"
>>>
>>>    static GDBusConnection*
>>> @@ -82,6 +85,7 @@ typedef struct TestDBusConsoleRegister {
>>>        GThread *thread;
>>>        GDBusConnection *listener_conn;
>>>        GDBusObjectManagerServer *server;
>>> +    bool with_map;
>>>    } TestDBusConsoleRegister;
>>>
>>>    static gboolean listener_handle_scanout(
>>> @@ -94,13 +98,48 @@ static gboolean listener_handle_scanout(
>>>        GVariant *arg_data,
>>>        TestDBusConsoleRegister *test)
>>>    {
>>> +    if (!test->with_map) {
>>> +        g_main_loop_quit(test->loop);
>>> +    }
>>> +
>>> +    return DBUS_METHOD_INVOCATION_HANDLED;
>>> +}
>>> +
>>> +static gboolean listener_handle_scanout_map(
>>> +    QemuDBusDisplay1ListenerUnixMap *object,
>>> +    GDBusMethodInvocation *invocation,
>>> +    GUnixFDList *fd_list,
>>> +    GVariant *arg_handle,
>>> +    guint arg_offset,
>>> +    guint arg_width,
>>> +    guint arg_height,
>>> +    guint arg_stride,
>>> +    guint arg_pixman_format,
>>> +    TestDBusConsoleRegister *test)
>>> +{
>>> +    int fd = -1;
>>> +    gint32 handle = g_variant_get_handle(arg_handle);
>>> +    g_autoptr(GError) error = NULL;
>>> +    void *addr = NULL;
>>> +    size_t len = arg_height * arg_stride;
>>> +
>>> +    g_assert_cmpuint(g_unix_fd_list_get_length(fd_list), ==, 1);
>>> +    fd = g_unix_fd_list_get(fd_list, handle, &error);
>>> +    g_assert_no_error(error);
>>> +
>>> +    addr = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, arg_offset);
>>> +    g_assert_no_errno(GPOINTER_TO_INT(addr));
>>
>> Strictly speaking, this construct is not safe. When void * is 64-bit and
>> int is 32-bit, this assetion will fail if the lower 32 bits of addr are
>> in [0x80000000, 0xffffffff] though addr may still be a valid address.
>> This is because GPOINTER_TO_INT() results in a negative value for such
>> an address, and g_assert_no_errno() asserts that the given value is
>> non-negative.
>>
>> Using g_mapped_file_new_from_fd() and will simplify this function as whole.
> 
> I thought about that, but g_mapped_file_new_from_fd() doesn't take a
> len, and it fstat() the fd. This is ok for memfd apparently, and
> appears to work, but it isn't really compliant with the dbus
> interface.

That's unfortunate. It seems we need to do:
g_assert_no_errno(addr == MAP_FAILED ? -1 : 0)

g_assert_nonnull() following this should be unnecessary by the way. It 
shouldn't happen unless the underlying platform is broken, which is 
irrelevant from the correctness of our code.

> 
>>
>>> +    g_assert_nonnull(addr);
>>> +    g_assert_no_errno(munmap(addr, len));
>>> +
>>>        g_main_loop_quit(test->loop);
>>>
>>> +    close(fd);
>>>        return DBUS_METHOD_INVOCATION_HANDLED;
>>>    }
>>>
>>>    static void
>>> -test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
>>> +test_dbus_console_setup_listener(TestDBusConsoleRegister *test, bool with_map)
>>>    {
>>>        g_autoptr(GDBusObjectSkeleton) listener = NULL;
>>>        g_autoptr(QemuDBusDisplay1ListenerSkeleton) iface = NULL;
>>> @@ -114,6 +153,20 @@ test_dbus_console_setup_listener(TestDBusConsoleRegister *test)
>>>                         NULL);
>>>        g_dbus_object_skeleton_add_interface(listener,
>>>                                             G_DBUS_INTERFACE_SKELETON(iface));
>>> +    if (with_map) {
>>> +        g_autoptr(QemuDBusDisplay1ListenerUnixMapSkeleton) iface_map =
>>> +            QEMU_DBUS_DISPLAY1_LISTENER_UNIX_MAP_SKELETON(
>>> +                qemu_dbus_display1_listener_unix_map_skeleton_new());
>>> +
>>> +        g_object_connect(iface_map,
>>> +                         "signal::handle-scanout-map", listener_handle_scanout_map, test,
>>> +                         NULL);
>>> +        g_dbus_object_skeleton_add_interface(listener,
>>> +                                             G_DBUS_INTERFACE_SKELETON(iface_map));
>>> +        g_object_set(iface, "interfaces",
>>> +            (const gchar *[]) { "org.qemu.Display1.Listener.Unix.Map", NULL },
>>> +            NULL);
>>> +    }
>>>        g_dbus_object_manager_server_export(test->server, listener);
>>>        g_dbus_object_manager_server_set_connection(test->server,
>>>                                                    test->listener_conn);
>>> @@ -145,7 +198,7 @@ test_dbus_console_registered(GObject *source_object,
>>>        g_assert_no_error(err);
>>>
>>>        test->listener_conn = g_thread_join(test->thread);
>>> -    test_dbus_console_setup_listener(test);
>>> +    test_dbus_console_setup_listener(test, test->with_map);
>>>    }
>>>
>>>    static gpointer
>>> @@ -155,7 +208,7 @@ test_dbus_p2p_server_setup_thread(gpointer data)
>>>    }
>>>
>>>    static void
>>> -test_dbus_display_console(void)
>>> +test_dbus_display_console(const void* data)
>>>    {
>>>        g_autoptr(GError) err = NULL;
>>>        g_autoptr(GDBusConnection) conn = NULL;
>>> @@ -163,7 +216,7 @@ test_dbus_display_console(void)
>>>        g_autoptr(GMainLoop) loop = NULL;
>>>        QTestState *qts = NULL;
>>>        int pair[2];
>>> -    TestDBusConsoleRegister test = { 0, };
>>> +    TestDBusConsoleRegister test = { 0, .with_map = GPOINTER_TO_INT(data) };
>>>    #ifdef WIN32
>>>        WSAPROTOCOL_INFOW info;
>>>        g_autoptr(GVariant) listener = NULL;
>>> @@ -299,7 +352,8 @@ main(int argc, char **argv)
>>>        g_test_init(&argc, &argv, NULL);
>>>
>>>        qtest_add_func("/dbus-display/vm", test_dbus_display_vm);
>>> -    qtest_add_func("/dbus-display/console", test_dbus_display_console);
>>> +    qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false), test_dbus_display_console);
>>> +    qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(true), test_dbus_display_console);
>>>        qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
>>>
>>>        return g_test_run();
>>
> 


