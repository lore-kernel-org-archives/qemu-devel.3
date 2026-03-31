Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963D0109B481
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7aWy-0000T4-31; Tue, 31 Mar 2026 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7Yop-0001Sj-JO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <machadovilaca@gmail.com>)
 id 1w7Yon-0002jy-1h
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-66a9a2187a5so8993001a12.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:07:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774962459; cv=none;
 d=google.com; s=arc-20240605;
 b=OxPvzK+sVG3KJDNoItkVVNzCM6Bt6e66H81l8/un9yVJp9JMknXS260G5Nu+gDdavQ
 JzFzASU9WegemmaY4gncREIRza/erD5BqgShnIUfqmbX5MvS1jNHnehQ3aRby2SZr07V
 UPaPZLz80YaFclnzn6G+CfSxoBt6hKU+4ZD75Rfqbnk/rxcWkAEzzHDvSt4lZE/MQkDr
 RN40XCRdhKIcikTYQB7tVPvu71QUvKl+kszPFsHqH49iH+w5/RfwXXvaljlvzY8wIYqT
 8S0ZCi8GFmLqtLE3d+Ge6RgUrxHySubx7fn/qNwahkJyi8wpOfa1ulMaxD7WOtIEgjJg
 qfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MRstTTnjr0U4bJnHlyyyN+hmGlsji+VDxiqKl4cVchg=;
 fh=JPgNlMd/t29lVJxP98ZsxvsF9F9Y6Lb8jMgl+MGXha8=;
 b=EXrhCAKpXrn+rgaY305iWwCKdRdzrtrenFSCmAyJ7W0W8nxtT38TxAN8KtUy7Xj9O9
 TdoMKXumW5/2v8gHQTfQ6RvJg1P5jt087H7OceDRwmY0LWu9ECzv6KhFd8IBpv9dx0+P
 FejrBPqAmsZYJkqJ0eKOlyxkYadPmZgchZuosbNpqZl4DPy1ekrN77VmR2xsJo161VgU
 tCvknAjhCDy74xNfOr4nt8f8GSC10L1xLvu0LixZzTANQl31WsbxsHyfEmJwSKaapzoD
 bmouEbee433amFC5584RPIOLTdCyme3LZh0qBToTm/XBmFANPrJzcekI5O13nYg2HZPt
 /fMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774962459; x=1775567259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MRstTTnjr0U4bJnHlyyyN+hmGlsji+VDxiqKl4cVchg=;
 b=WvXx41FYlyakWV6DJ89yqADzQu7bUlVzeV4W7H2Vhw7uD+JH+vwAr69mYPq7tUu5PV
 /RBT5LK6UQfX3tlPcPhxq3NcBCHLrjmtHJSLKqtWeFu034iFRldCXTyN6uDrMNMlHV9d
 7QUe4TvMJNeGkfdWcsenj2dccFlPk668zCXpoeyhJgVJzjB6zrnQBlK4sYlGTPGqJxKF
 ztYluS2Z7z7LNl9RBQ4zK3MKu79NbeP3cYX5Pqa6xnqmTD4cOp5nJnzB3nhoGVn2rb3T
 7JiTPKjdRchjj4sr+MyK/vMn29fSua/8YouZb80Xth2aEzh9Zi4J8MVVzZICQknDVHon
 da+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962459; x=1775567259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRstTTnjr0U4bJnHlyyyN+hmGlsji+VDxiqKl4cVchg=;
 b=E7pqS8ojaXoB2sM2t7iDPRYPUpsWoLTNRgAh6vXsAH50UhbR7UpgLzwGeE/x0d7eGc
 5ux8e1XiYZRnYnb+ieoZ7awhY3CIywC8QaivP73bX7L8LIBKWy7RWSyeTzpqGR4Qd3JL
 rfg7BXJeO6akWEyifNKUSC7vcoT9ZIhsl+EqYty23M6pUVqIO8hxG43TQFpyavrsSyE7
 Xn5E1C8HAF/ut1qvjgcgcIRIRmjogxBSQtfxRao1Ofj6IY5jHEe6gIdfyY30cvjHk+Lz
 XSGc+/FYSg0HSSNZcf396l3m/P0DgPJAPHx9t3jr4LoeOdAY9bS294taCtz+Y9eo+2wq
 qdVw==
X-Gm-Message-State: AOJu0Yy0gPWAivJRi3Enm42B5RORPoBaq7k2j563ufr7vidhJ/PtVRKo
 pM1akji193ftL+uOMGO/8wLTBs3hhzE6HyE2SNp0+7/XuMrL1+t+iEf8Y95q0B+aYGSkSjRsCJs
 6jGCWppoinN2zRNw/8dyF7uw0o37TWlY=
X-Gm-Gg: ATEYQzw/n/sM6a0MfggMDw62+RKQTc6oXFBF5az2EY2/4+g6TA0Kf3maBf2jV+DUf4e
 5ibzXWNhYw2XssvfDxh748mo0kUfmF9vDb+m3PZKddHhXg5FU/SjMgGETRezeQnyorkhTFjJ/y/
 nGH+eTFrtUfBrzqfeIQLSG5sYLmHtTUY4J5BDVmQGg2U7RMl1HfnscJy7t79kFTUpNwbOvVvJgO
 MH/SAQz9udZPzDy4Y9EPIKyAXl2itUOpQ0amiGLAwX6gLy6ZgAjfhWZ9Wl9irnIjvQw17kLs6/E
 jf21TZRVMtG/zP9gRKHI1AOZgb3jhNLSmBRNn2WErPpCHoLG
X-Received: by 2002:a05:6402:2685:b0:66c:2532:4e5f with SMTP id
 4fb4d7f45d1cf-66c25324f2amr2538534a12.1.1774962458818; Tue, 31 Mar 2026
 06:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260331110135.92883-1-machadovilaca@gmail.com>
 <CAPMcbCpJsiTs95g_8v+AkNCL7LhVAK+CZM=X-y+-kbRDd41bSA@mail.gmail.com>
In-Reply-To: <CAPMcbCpJsiTs95g_8v+AkNCL7LhVAK+CZM=X-y+-kbRDd41bSA@mail.gmail.com>
From: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <machadovilaca@gmail.com>
Date: Tue, 31 Mar 2026 14:07:27 +0100
X-Gm-Features: AQROBzAedh_ym6BxpREwZcWpU3W6rLq4jMu0OozdJorQ-fovRHD8P4EdOcS22BU
Message-ID: <CAPM7mp10RGfhV7hpnhDcvm_fj7Ks=ozK=2=MTew-4fKKmxq8pA@mail.gmail.com>
Subject: Re: [PATCH] qga: implement 'guest-get-nvidia-smi' command
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d8fc64064e51a678"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=machadovilaca@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 31 Mar 2026 10:57:12 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000d8fc64064e51a678
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Monitoring, on the hypervisor side, of GPU workloads running in guests with
NVIDIA GPU passthrough (VFIO) or vGPU (NVIDIA GRID).
Operators who want GPU metrics from a fleet of VMs must either SSH into
each guest or deploy a separate monitoring agent inside the guest itself
(e.g. DCGM exporter).

On Tue, 31 Mar 2026 at 13:57, Kostiantyn Kostiuk <kkostiuk@redhat.com>
wrote:

> Hi Jo=C3=A3o,
>
> Thanks for your patch. Can you explain the use case of this command?
>
> Best Regards,
> Kostiantyn Kostiuk.
>
>
> On Tue, Mar 31, 2026 at 2:02=E2=80=AFPM Jo=C3=A3o Vila=C3=A7a <machadovil=
aca@gmail.com>
> wrote:
>
>> ---
>>  qga/commands-posix.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>>  qga/commands-win32.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
>>  qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 187 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index 837be51c40..631a8a9ee6 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp=
)
>>      return ret;
>>  }
>>  #endif
>> +
>> +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
>> +{
>> +    const gchar *argv[] =3D {
>> +        "nvidia-smi",
>> +        "--query-gpu=3Dindex,name,driver_version,"
>> +            "temperature.gpu,utilization.gpu,utilization.memory,"
>> +            "memory.total,memory.free,memory.used",
>> +        "--format=3Dcsv,noheader,nounits",
>> +        NULL
>> +    };
>> +    g_autofree gchar *stdout_buf =3D NULL;
>> +    g_autofree gchar *stderr_buf =3D NULL;
>> +    gint exit_status;
>> +    GError *gerr =3D NULL;
>> +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
>> +
>> +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
>> +                      G_SPAWN_SEARCH_PATH,
>> +                      NULL, NULL,
>> +                      &stdout_buf, &stderr_buf,
>> +                      &exit_status, &gerr)) {
>> +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message)=
;
>> +        g_error_free(gerr);
>> +        return NULL;
>> +    }
>> +
>> +    if (exit_status !=3D 0) {
>> +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
>> +                   exit_status, stderr_buf ? stderr_buf : "unknown
>> error");
>> +        return NULL;
>> +    }
>> +
>> +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
>> +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
>> +        gchar *line =3D g_strstrip(lines[i]);
>> +        if (*line =3D=3D '\0') {
>> +            continue;
>> +        }
>> +
>> +        gchar **f =3D g_strsplit(line, ", ", 9);
>> +        if (g_strv_length(f) < 9) {
>> +            g_strfreev(f);
>> +            continue;
>> +        }
>> +
>> +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
>> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10=
);
>> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
>> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
>> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10=
);
>> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10=
);
>> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10=
);
>> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10=
);
>> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10=
);
>> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10=
);
>> +
>> +        QAPI_LIST_APPEND(tail, gpu);
>> +        g_strfreev(f);
>> +    }
>> +    g_strfreev(lines);
>> +
>> +    return head;
>> +}
>> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> index c0bf3467bd..a78d5b71f5 100644
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -2764,3 +2764,67 @@ GuestNetworkRouteList
>> *qmp_guest_network_get_route(Error **errp)
>>      g_hash_table_destroy(interface_metric_cache);
>>      return head;
>>  }
>> +
>> +GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)
>> +{
>> +    const gchar *argv[] =3D {
>> +        "nvidia-smi",
>> +        "--query-gpu=3Dindex,name,driver_version,"
>> +            "temperature.gpu,utilization.gpu,utilization.memory,"
>> +            "memory.total,memory.free,memory.used",
>> +        "--format=3Dcsv,noheader,nounits",
>> +        NULL
>> +    };
>> +    g_autofree gchar *stdout_buf =3D NULL;
>> +    g_autofree gchar *stderr_buf =3D NULL;
>> +    gint exit_status;
>> +    GError *gerr =3D NULL;
>> +    GuestNvidiaGpuList *head =3D NULL, **tail =3D &head;
>> +
>> +    if (!g_spawn_sync(NULL, (gchar **)argv, NULL,
>> +                      G_SPAWN_SEARCH_PATH,
>> +                      NULL, NULL,
>> +                      &stdout_buf, &stderr_buf,
>> +                      &exit_status, &gerr)) {
>> +        error_setg(errp, "failed to run nvidia-smi: %s", gerr->message)=
;
>> +        g_error_free(gerr);
>> +        return NULL;
>> +    }
>> +
>> +    if (exit_status !=3D 0) {
>> +        error_setg(errp, "nvidia-smi failed (exit %d): %s",
>> +                   exit_status, stderr_buf ? stderr_buf : "unknown
>> error");
>> +        return NULL;
>> +    }
>> +
>> +    gchar **lines =3D g_strsplit(stdout_buf, "\n", -1);
>> +    for (int i =3D 0; lines[i] !=3D NULL; i++) {
>> +        gchar *line =3D g_strstrip(lines[i]);
>> +        if (*line =3D=3D '\0') {
>> +            continue;
>> +        }
>> +
>> +        gchar **f =3D g_strsplit(line, ", ", 9);
>> +        if (g_strv_length(f) < 9) {
>> +            g_strfreev(f);
>> +            continue;
>> +        }
>> +
>> +        GuestNvidiaGpu *gpu     =3D g_new0(GuestNvidiaGpu, 1);
>> +        gpu->index              =3D (int)g_ascii_strtoll(f[0], NULL, 10=
);
>> +        gpu->name               =3D g_strdup(g_strstrip(f[1]));
>> +        gpu->driver_version     =3D g_strdup(g_strstrip(f[2]));
>> +        gpu->temperature        =3D (int)g_ascii_strtoll(f[3], NULL, 10=
);
>> +        gpu->gpu_utilization    =3D (int)g_ascii_strtoll(f[4], NULL, 10=
);
>> +        gpu->memory_utilization =3D (int)g_ascii_strtoll(f[5], NULL, 10=
);
>> +        gpu->memory_total       =3D (int)g_ascii_strtoll(f[6], NULL, 10=
);
>> +        gpu->memory_free        =3D (int)g_ascii_strtoll(f[7], NULL, 10=
);
>> +        gpu->memory_used        =3D (int)g_ascii_strtoll(f[8], NULL, 10=
);
>> +
>> +        QAPI_LIST_APPEND(tail, gpu);
>> +        g_strfreev(f);
>> +    }
>> +    g_strfreev(lines);
>> +
>> +    return head;
>> +}
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index c57bc9a02f..8abbf71131 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -1876,6 +1876,65 @@
>>    'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
>>  }
>>
>> +##
>> +# @GuestNvidiaGpu:
>> +#
>> +# Information about a single NVIDIA GPU as reported by nvidia-smi.
>> +#
>> +# @index: GPU index (0-based), stable across reboots for a given
>> +#         hardware slot
>> +#
>> +# @name: GPU product name (e.g. "NVIDIA A100-SXM4-80GB")
>> +#
>> +# @driver-version: version string of the installed NVIDIA driver
>> +#
>> +# @temperature: GPU die temperature in degrees Celsius
>> +#
>> +# @gpu-utilization: GPU compute engine utilization in percent (0-100)
>> +#
>> +# @memory-utilization: GPU memory controller utilization in percent
>> +#                      (0-100)
>> +#
>> +# @memory-total: total framebuffer memory in MiB
>> +#
>> +# @memory-free: free framebuffer memory in MiB
>> +#
>> +# @memory-used: used framebuffer memory in MiB
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'GuestNvidiaGpu',
>> +  'data': {
>> +      'index':              'int',
>> +      'name':               'str',
>> +      'driver-version':     'str',
>> +      'temperature':        'int',
>> +      'gpu-utilization':    'int',
>> +      'memory-utilization': 'int',
>> +      'memory-total':       'int',
>> +      'memory-free':        'int',
>> +      'memory-used':        'int'
>> +  }
>> +}
>> +
>> +##
>> +# @guest-get-nvidia-smi:
>> +#
>> +# Query NVIDIA GPU information via nvidia-smi inside the guest.
>> +#
>> +# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)
>> +# detected by the NVIDIA driver.
>> +#
>> +# Errors:
>> +#   - If nvidia-smi is not installed or not found in $PATH
>> +#   - If nvidia-smi exits with a non-zero status (e.g. no NVIDIA
>> +#     device)
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'command': 'guest-get-nvidia-smi',
>> +  'returns': ['GuestNvidiaGpu'] }
>> +
>>  ##
>>  # @GuestNetworkRoute:
>>  #
>> --
>> 2.53.0
>>
>>

--000000000000d8fc64064e51a678
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Monitoring, on the hypervisor side, of GPU workloads runni=
ng in guests with NVIDIA GPU passthrough (VFIO) or vGPU (NVIDIA GRID).<br>O=
perators who want GPU metrics from a fleet of VMs must either SSH into each=
 guest or deploy a separate monitoring agent inside the guest itself (e.g. =
DCGM exporter).</div><br><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, 31 Mar 2026 at 13:57, Kostiant=
yn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div>Hi=C2=A0Jo=C3=A3o,</div><div><br></div><div>Thanks for =
your patch. Can you explain the use case of this command?=C2=A0</div><div><=
br></div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><=
div>Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Mar 31, 2026 at 2:02=E2=80=AFPM Jo=C3=A3o Vila=C3=A7a &lt;<a href=
=3D"mailto:machadovilaca@gmail.com" target=3D"_blank">machadovilaca@gmail.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">---<br>
=C2=A0qga/commands-posix.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-win32.c | 64 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/qapi-schema.json | 59 ++++++++++++++++++++++++++++++++++++++++<br=
>
=C2=A03 files changed, 187 insertions(+)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 837be51c40..631a8a9ee6 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1415,3 +1415,67 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)<b=
r>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
=C2=A0#endif<br>
+<br>
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_version,=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utilizatio=
n.gpu,utilization.memory,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.free,m=
emory.used&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
+=C2=A0 =C2=A0 gint exit_status;<br>
+=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
+=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 G_SPAWN_SEARCH_PATH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;exit_status, &amp;gerr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvidia-sm=
i: %s&quot;, gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed (exit=
 %d): %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_=
status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;, -1)=
;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &quot;,=
 9);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=3D g_n=
ew0(GuestNvidiaGpu, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=A0=3D =
g_strdup(g_strstrip(f[2]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D (int)=
g_ascii_strtoll(f[4], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_ascii_st=
rtoll(f[5], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_strfreev(lines);<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index c0bf3467bd..a78d5b71f5 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -2764,3 +2764,67 @@ GuestNetworkRouteList *qmp_guest_network_get_route(E=
rror **errp)<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_destroy(interface_metric_cache);<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
+<br>
+GuestNvidiaGpuList *qmp_guest_get_nvidia_smi(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const gchar *argv[] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;nvidia-smi&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--query-gpu=3Dindex,name,driver_version,=
&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;temperature.gpu,utilizatio=
n.gpu,utilization.memory,&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;memory.total,memory.free,m=
emory.used&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--format=3Dcsv,noheader,nounits&quot;,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
+=C2=A0 =C2=A0 };<br>
+=C2=A0 =C2=A0 g_autofree gchar *stdout_buf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree gchar *stderr_buf =3D NULL;<br>
+=C2=A0 =C2=A0 gint exit_status;<br>
+=C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
+=C2=A0 =C2=A0 GuestNvidiaGpuList *head =3D NULL, **tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_spawn_sync(NULL, (gchar **)argv, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 G_SPAWN_SEARCH_PATH,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;stdout_buf, &amp;stderr_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;exit_status, &amp;gerr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to run nvidia-sm=
i: %s&quot;, gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_error_free(gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (exit_status !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;nvidia-smi failed (exit=
 %d): %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_=
status, stderr_buf ? stderr_buf : &quot;unknown error&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 gchar **lines =3D g_strsplit(stdout_buf, &quot;\n&quot;, -1)=
;<br>
+=C2=A0 =C2=A0 for (int i =3D 0; lines[i] !=3D NULL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar *line =3D g_strstrip(lines[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*line =3D=3D &#39;\0&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gchar **f =3D g_strsplit(line, &quot;, &quot;,=
 9);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_length(f) &lt; 9) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestNvidiaGpu *gpu=C2=A0 =C2=A0 =C2=A0=3D g_n=
ew0(GuestNvidiaGpu, 1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;index=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D (int)g_ascii_strtoll(f[0], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0=3D g_strdup(g_strstrip(f[1]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;driver_version=C2=A0 =C2=A0 =C2=A0=3D =
g_strdup(g_strstrip(f[2]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;temperature=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[3], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;gpu_utilization=C2=A0 =C2=A0 =3D (int)=
g_ascii_strtoll(f[4], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_utilization =3D (int)g_ascii_st=
rtoll(f[5], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_total=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (int)g_ascii_strtoll(f[6], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_free=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[7], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpu-&gt;memory_used=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =3D (int)g_ascii_strtoll(f[8], NULL, 10);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, gpu);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(f);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_strfreev(lines);<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c57bc9a02f..8abbf71131 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1876,6 +1876,65 @@<br>
=C2=A0 =C2=A0&#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_WIN32&#39;, &#39;C=
ONFIG_GETLOADAVG&#39;] }<br>
=C2=A0}<br>
<br>
+##<br>
+# @GuestNvidiaGpu:<br>
+#<br>
+# Information about a single NVIDIA GPU as reported by nvidia-smi.<br>
+#<br>
+# @index: GPU index (0-based), stable across reboots for a given<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hardware slot<br>
+#<br>
+# @name: GPU product name (e.g. &quot;NVIDIA A100-SXM4-80GB&quot;)<br>
+#<br>
+# @driver-version: version string of the installed NVIDIA driver<br>
+#<br>
+# @temperature: GPU die temperature in degrees Celsius<br>
+#<br>
+# @gpu-utilization: GPU compute engine utilization in percent (0-100)<br>
+#<br>
+# @memory-utilization: GPU memory controller utilization in percent<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (0-100)<br>
+#<br>
+# @memory-total: total framebuffer memory in MiB<br>
+#<br>
+# @memory-free: free framebuffer memory in MiB<br>
+#<br>
+# @memory-used: used framebuffer memory in MiB<br>
+#<br>
+# Since: 10.1<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestNvidiaGpu&#39;,<br>
+=C2=A0 &#39;data&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;index&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;name&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&#39;str&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;driver-version&#39;:=C2=A0 =C2=A0 =C2=A0&#39;str=
&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;temperature&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;gpu-utilization&#39;:=C2=A0 =C2=A0 &#39;int&#39;=
,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-utilization&#39;: &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-total&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0&#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-free&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;memory-used&#39;:=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#3=
9;int&#39;<br>
+=C2=A0 }<br>
+}<br>
+<br>
+##<br>
+# @guest-get-nvidia-smi:<br>
+#<br>
+# Query NVIDIA GPU information via nvidia-smi inside the guest.<br>
+#<br>
+# Returns one @GuestNvidiaGpu entry per physical GPU (or MIG instance)<br>
+# detected by the NVIDIA driver.<br>
+#<br>
+# Errors:<br>
+#=C2=A0 =C2=A0- If nvidia-smi is not installed or not found in $PATH<br>
+#=C2=A0 =C2=A0- If nvidia-smi exits with a non-zero status (e.g. no NVIDIA=
<br>
+#=C2=A0 =C2=A0 =C2=A0device)<br>
+#<br>
+# Since: 10.1<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-get-nvidia-smi&#39;,<br>
+=C2=A0 &#39;returns&#39;: [&#39;GuestNvidiaGpu&#39;] }<br>
+<br>
=C2=A0##<br>
=C2=A0# @GuestNetworkRoute:<br>
=C2=A0#<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000d8fc64064e51a678--

