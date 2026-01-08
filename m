Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2291D185C9
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 10:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnUR-0003P9-Tg; Thu, 08 Jan 2026 05:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUQ-0003Or-VX
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:43:38 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vdnUP-0005Az-2x
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 05:43:38 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4ffbc2b861eso13863101cf.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767869016; x=1768473816; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NQsyLh98QGB0C89U/YCRvAg6REtOw7LsSNo8S+jSfFM=;
 b=UlMtR4ckcYfIovN5idPrOVkH4IRsh+QsCa3+bzWiFlGY8B5uTFtkuJhvOF2lgtPDtp
 zFG9pFxZ6840dj2TM6Qes8bZC8WXw0Dm9xDrTi8qgYk4ieITgdQOF7SwKPpPshtSO9CA
 56ri8oxzbuxTtvHzegc4Rh5hEAl7/qHyKvOzA0k8uN1Spm/Hqr7J1PqfK1umOSsVBsCt
 SnnVl0CLtPIsftAyq0kYBnVaMjdHzEI9/mMJfePpj+HSzGWAkUfSTA6OUHzw2w0xVrN8
 a9yXMBZlF+eXXpRHZzdv5PZ74QgLwyvz/IvfY3bGPR1FRiUpLdbxbCHcu2HahU6iAZcn
 Vsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767869016; x=1768473816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NQsyLh98QGB0C89U/YCRvAg6REtOw7LsSNo8S+jSfFM=;
 b=YRkp9IpZxFOC3K822KaOLqc+PIhlAw+u+raX7sE2s/0saCDXutHa9Pk5tPIKNvohG/
 RVu2rQlediAmcLd5iAyoSILdABWnZPss2uP5+FySLo7+OrDUIhPBClnKubzwGfwNeYpS
 wY6NIUHfgDfj7NFI0CFx3p/YYUTSfuN0fgaSSHBrVXAJvKfP3PPuBT1Hd8ecxRsxZ7+T
 i22joUKMEMkZeHzGh2yTKsGEEnyr+GMcT/NPKIvU5V0tneUuAe0Unu5Yb/U7/Wf+mmNm
 YSE4P+NcYDRTWM410Ty5ndiPYdJyphmQdercl2+HaDvvkgGfxf9xOoapj6GIzj77pYOx
 80Ew==
X-Gm-Message-State: AOJu0Yynum6HQi5EKvGuaLZwAztju8UAOidQfxyDCEXrg1j0GSlRRvPj
 QTvo4l4ZJZBRCWZia94AWRY7pP1oCK3iqgZnzNqpjNBjsOGKiqnXZF7BiBq3AbsllsHrb11cedR
 tG0MakSDszhgPvYzTlIoEd12ZgHRsJAA=
X-Gm-Gg: AY/fxX5d2pjJzP1TDePnmrliLvX8OZXdxlK8fme+ZKtigFkUNAQHKnleVOXpuCXFo0F
 W8CrC8SonT0IM4DgIvGgoTCseGDL3q1q52GZ5I0NX9d7nyaRaZO5MhT914mHLvIHi8z0fu2QoK2
 5tyjzTMJI0dPlCw/aTtEWHSx3Hqxa5fUR/74b0BjJzaFIXbUd6HI9fAT5aJETC2IKu7ehXbJaRm
 MOGUjUzS+QEu0gPICH9KcnXZGbold3SNhgIVL+n7vmbmdeNFyY9/Q2bNpVK1ZeTjVt5lOVtHImu
 oIQAkb6NIfAvf0YZkpbOH+Ad7oA=
X-Google-Smtp-Source: AGHT+IFOki2ojrlK/iLbg347YOnEUkNLsPqy0bExgpdEU0fmW86DNXhjPTjnElkbvevbt30qEDNV5u/mLqAK6NsOXF0=
X-Received: by 2002:a05:622a:1f13:b0:4f1:c6c4:dbcf with SMTP id
 d75a77b69052e-4ffb4a3ffabmr78949221cf.41.1767869015807; Thu, 08 Jan 2026
 02:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20260107153442.1832957-1-berrange@redhat.com>
 <20260107153442.1832957-2-berrange@redhat.com>
In-Reply-To: <20260107153442.1832957-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Jan 2026 14:43:22 +0400
X-Gm-Features: AQt7F2p4LhA5hXy-_t4d9GzmdVjhM7aGHxJ53zTvcn4uxnAb47TWTa_l6RHM1Bo
Message-ID: <CAJ+F1C+XKd-y9LA9rctwFZQn=11d3j6zB+S2wFTfznELjQRcdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] io: separate freeing of tasks from marking them as
 complete
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, zoudongjie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

On Wed, Jan 7, 2026 at 7:36=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> The original design of QIOTask was intended to simplify lifecycle
> management by automatically freeing it when the task was marked as
> complete. This overlooked the fact that when a QIOTask is used in
> combination with a GSource, there may be times when the source
> callback is never invoked. This is typically when a GSource is
> released before any I/O event arrives. In such cases it is not
> desirable to mark a QIOTask as complete, but it still needs to be
> freed. To satisfy this, the task must be released manually.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/io/task.h         | 29 +++++++++++++++++++++--------
>  io/channel-tls.c          |  4 ++++
>  io/channel-websock.c      |  3 +++
>  io/task.c                 |  8 ++++++--
>  tests/unit/test-io-task.c | 26 ++++++++++++++++++++++++++
>  5 files changed, 60 insertions(+), 10 deletions(-)
>
> diff --git a/include/io/task.h b/include/io/task.h
> index 0b5342ee84..98847f5994 100644
> --- a/include/io/task.h
> +++ b/include/io/task.h
> @@ -96,7 +96,7 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
>   *                         1000,
>   *                         myobject_operation_timer,
>   *                         task,
> - *                         NULL);
> + *                         qio_task_free);
>   *    }
>   *   </programlisting>
>   * </example>
> @@ -138,9 +138,8 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
>   * the callback func 'myobject_operation_notify' shown
>   * earlier to deal with the results.
>   *
> - * Once this function returns false, object_unref will be called
> - * automatically on the task causing it to be released and the
> - * ref on QMyObject dropped too.
> + * Once this function returns FALSE, the task will be freed,
> + * causing it release the ref on QMyObject too.
>   *
>   * The QIOTask module can also be used to perform operations
>   * in a background thread context, while still reporting the
> @@ -208,8 +207,8 @@ typedef void (*QIOTaskWorker)(QIOTask *task,
>   * 'err' attribute in the task object to determine if
>   * the operation was successful or not.
>   *
> - * The returned task will be released when qio_task_complete()
> - * is invoked.
> + * The returned task must be released by calling
> + * qio_task_free() when no longer required.
>   *
>   * Returns: the task struct
>   */
> @@ -218,6 +217,19 @@ QIOTask *qio_task_new(Object *source,
>                        gpointer opaque,
>                        GDestroyNotify destroy);
>
> +/**
> + * qio_task_free:
> + * task: the task object to free
> + *
> + * Free the resources associated with the task. Typically
> + * the qio_task_complete() method will be called immediately
> + * before this to trigger the task callback, however, it is
> + * permissible to free the task in the case of cancellation.
> + * The destroy callback will be used to release the opaque
> + * data provided to qio_task_new().
> + */
> +void qio_task_free(QIOTask *task);
> +
>  /**
>   * qio_task_run_in_thread:
>   * @task: the task struct
> @@ -268,8 +280,9 @@ void qio_task_wait_thread(QIOTask *task);
>   * qio_task_complete:
>   * @task: the task struct
>   *
> - * Invoke the completion callback for @task and
> - * then free its memory.
> + * Invoke the completion callback for @task. This should typically
> + * only be invoked once on a task, and then qio_task_free() used
> + * to free it.
>   */
>  void qio_task_complete(QIOTask *task);
>
> diff --git a/io/channel-tls.c b/io/channel-tls.c
> index b0cec27cb9..07274c12df 100644
> --- a/io/channel-tls.c
> +++ b/io/channel-tls.c
> @@ -170,6 +170,7 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,
>          trace_qio_channel_tls_handshake_fail(ioc);
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> +        qio_task_free(task);
>          return;
>      }
>
> @@ -183,6 +184,7 @@ static void qio_channel_tls_handshake_task(QIOChannel=
TLS *ioc,
>              trace_qio_channel_tls_credentials_allow(ioc);
>          }
>          qio_task_complete(task);
> +        qio_task_free(task);
>      } else {
>          GIOCondition condition;
>          QIOChannelTLSData *data =3D g_new0(typeof(*data), 1);
> @@ -270,11 +272,13 @@ static void qio_channel_tls_bye_task(QIOChannelTLS =
*ioc, QIOTask *task,
>          trace_qio_channel_tls_bye_fail(ioc);
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> +        qio_task_free(task);
>          return;
>      }
>
>      if (status =3D=3D QCRYPTO_TLS_BYE_COMPLETE) {
>          qio_task_complete(task);
> +        qio_task_free(task);
>          return;
>      }
>
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index cb4dafdebb..b4f96a0af4 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -545,6 +545,7 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
>          trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> +        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> @@ -561,6 +562,7 @@ static gboolean qio_channel_websock_handshake_send(QI=
OChannel *ioc,
>              trace_qio_channel_websock_handshake_complete(ioc);
>              qio_task_complete(task);
>          }
> +        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> @@ -588,6 +590,7 @@ static gboolean qio_channel_websock_handshake_io(QIOC=
hannel *ioc,
>          trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(e=
rr));
>          qio_task_set_error(task, err);
>          qio_task_complete(task);
> +        qio_task_free(task);
>          wioc->hs_io_tag =3D 0;
>          return FALSE;
>      }
> diff --git a/io/task.c b/io/task.c
> index 451f26f8b4..331febd4e1 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -70,8 +70,12 @@ QIOTask *qio_task_new(Object *source,
>      return task;
>  }
>
> -static void qio_task_free(QIOTask *task)
> +void qio_task_free(QIOTask *task)
>  {
> +    if (!task) {
> +        return;
> +    }
> +
>      qemu_mutex_lock(&task->thread_lock);
>      if (task->thread) {
>          if (task->thread->destroy) {
> @@ -110,6 +114,7 @@ static gboolean qio_task_thread_result(gpointer opaqu=
e)
>
>      trace_qio_task_thread_result(task);
>      qio_task_complete(task);
> +    qio_task_free(task);
>
>      return FALSE;
>  }
> @@ -196,7 +201,6 @@ void qio_task_complete(QIOTask *task)
>  {
>      task->func(task, task->opaque);
>      trace_qio_task_complete(task);
> -    qio_task_free(task);
>  }
>
>
> diff --git a/tests/unit/test-io-task.c b/tests/unit/test-io-task.c
> index 115dba8970..b1c8ecb7ab 100644
> --- a/tests/unit/test-io-task.c
> +++ b/tests/unit/test-io-task.c
> @@ -73,6 +73,7 @@ static void test_task_complete(void)
>      src =3D qio_task_get_source(task);
>
>      qio_task_complete(task);
> +    qio_task_free(task);
>
>      g_assert(obj =3D=3D src);
>
> @@ -84,6 +85,28 @@ static void test_task_complete(void)
>  }
>
>
> +static void test_task_cancel(void)
> +{
> +    QIOTask *task;
> +    Object *obj =3D object_new(TYPE_DUMMY);
> +    Object *src;
> +    struct TestTaskData data =3D { NULL, NULL, false };
> +
> +    task =3D qio_task_new(obj, task_callback, &data, NULL);
> +    src =3D qio_task_get_source(task);
> +
> +    qio_task_free(task);
> +
> +    g_assert(obj =3D=3D src);
> +
> +    object_unref(obj);
> +
> +    g_assert(data.source =3D=3D NULL);
> +    g_assert(data.err =3D=3D NULL);
> +    g_assert(data.freed =3D=3D false);
> +}
> +
> +
>  static void task_data_free(gpointer opaque)
>  {
>      struct TestTaskData *data =3D opaque;
> @@ -101,6 +124,7 @@ static void test_task_data_free(void)
>      task =3D qio_task_new(obj, task_callback, &data, task_data_free);
>
>      qio_task_complete(task);
> +    qio_task_free(task);
>
>      object_unref(obj);
>
> @@ -123,6 +147,7 @@ static void test_task_failure(void)
>
>      qio_task_set_error(task, err);
>      qio_task_complete(task);
> +    qio_task_free(task);
>
>      object_unref(obj);
>
> @@ -260,6 +285,7 @@ int main(int argc, char **argv)
>      module_call_init(MODULE_INIT_QOM);
>      type_register_static(&dummy_info);
>      g_test_add_func("/crypto/task/complete", test_task_complete);
> +    g_test_add_func("/crypto/task/cancel", test_task_cancel);
>      g_test_add_func("/crypto/task/datafree", test_task_data_free);
>      g_test_add_func("/crypto/task/failure", test_task_failure);
>      g_test_add_func("/crypto/task/thread_complete", test_task_thread_com=
plete);
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

