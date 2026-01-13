Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278AD29DC7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 04:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfVfp-0005eh-M0; Mon, 12 Jan 2026 23:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vfVfn-0005ae-JH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 23:06:27 -0500
Received: from esa14.hc2706-39.iphmx.com ([216.71.140.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vfVfj-0005QK-Nf
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 23:06:27 -0500
X-CSE-ConnectionGUID: 1NIEUOS8RhuEoiGPZKn/zA==
X-CSE-MsgGUID: TzHvwICZRcSU3Qj8B5lqkg==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.222.70
X-IronPort-MID: 119627427
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:WE5VhK1wDPKDW7kWdPbD5YRwkn2cJEfYwER7XKvMYLTBsI5bpzVRm
 DAaWDqHP/jcZjTwfN4jOdy/8B8DuMTUy99iTwJqqSg9HnlHl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0bP656yI6jf3ULlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhXguawr414rZ8Ekx5K2r4mtD1rADTasjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbZLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOggqe0Iw/ylWZcWq8VJcSJS1mZX7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lNzaiqt+R++KBSvRBgcUMFPvIOsQNkyQ1pd3ZJa5OrZHrRqzL4ZpF1W51iJ8WW/nZY
 MUdZHxkaxGojx9nYA9GTsJj2r3y3D+gK1W0q3rMzUYzy2HX3Ap9ypDnLZzYdsHiqcB9xx/J+
 DiZoz6mav0cHOCN6SSa01mevOT0oHjCWtI4Sbmh9fE/1TV/wURWUnX6T2CTuPS8lwuyVsxSL
 2QS/Swhq7V081akJuQRRDW9qX+A+wMVAp9eTLV85waKxa7ZpQ2eAwDoUwJ8VTDvj+dvLRQC3
 ELPkt/0bQGDepXMIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:sezLfqnqCODn3+1iaY2PMD7b5avpDfK33DAbv31ZSRFFG/FwWf
 re48jzsiWE+Qr5OUtQ5+xoXZPrfZqyz+8M3WB8B8bHYOCighrQEGgA1/qF/9SDIVyFygc178
 4JGNkdebjN5BpB/KHHCWKDYqsdKbe8gdyVrNab4HF3UwlwZq1sqyt/AB2KC1B7SWB9aaYRJd
 6z4o5pqzK8ZW8adK2AdwI4dtmGidmOupyOW3A77t0chzVmTwnE1Fc3KXil9yZbdQ9z6pEf1k
 WAuzDFx8yYwoGGI9bnth6x06hr
X-Talos-CUID: 9a23:AqIDqW6fgOjqrD1JMNssrWg1N/0CSS3nzGr9JE6XMVRKTvqHYArF
X-Talos-MUID: 9a23:qAcjpQafbd5MDeBTiy3Mmi5DH/VS6J+TU3kPwb9bv9CHOnkl
Received: from mail-ua1-f70.google.com ([209.85.222.70])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 12 Jan 2026 23:06:16 -0500
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-945e4fb842dso10083883241.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 20:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1768277177; x=1768881977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F7QCiIAiszhgIfPA8ReNQJuD6eZluhYRaXxwVrkvTrk=;
 b=CwfTe7IyEcvOqyLm67Wk52tBSVr29rXx9AxQ1DbvVHaJfJjAxoMt1ZU7v0OW8jrI7j
 386UHascxY5ZMwLyg+l1vGYu0wjrWQxEO7WtcPJn0Le3Ow5nETsrJxa+Bu1bIc9noPIL
 HNT2G02SAONIAq0wB+GyFmvSRpEU9PJq/mgDsOZAskeSaEfwdhePluXWrr4cZ/VXLa3s
 hEnhiuloOYTU30NzOaqKNVNeltPo7gY+Vchw+By6z4js0h12c9HQYAoGLFluWBWEf99B
 w6bacBP0CMMuVAuVgOxVp2Mh5f+gvmuozyhD6M3aAkuw153QxILIFtiFzEPHIibeyvXk
 Tayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768277177; x=1768881977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7QCiIAiszhgIfPA8ReNQJuD6eZluhYRaXxwVrkvTrk=;
 b=YUst8UfyTk+nxVGZCXslqTbqbBrGh3UUlscxa6Qp5vJ324A9Gbe6fGJJHNt9LwhE3r
 MrKF5tnfaoIIwmGq0WTVaZCQuEBTgVDW4nnXhcMEmk9Ih4+REY32ZRBLldfR7p7uyHhW
 j2Ilmu6EUQY/7atv35DYA2+bOfSKIE2pyVeKkqEFhiZPE++5pdBznd39uBJC8+QI13Bo
 BR/BGlJ0sAasm7Ewj2ESHnCY+8f+ZoFh0PJhWkkBfgP+HlRe1Mt7t04OHDIHXqA1Lg/K
 y18YKVjW0iCszOhYRgtVuQL6i50oZaKi+rktUc7mO0iu1uT/Mvi7TMKeayfbDqeK5Mj3
 u+vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRn4e+1iTH5kHCgmDWlVfDZuUK7jPz204RZDsih2j7F45Y/eEryMn8xOrMDHczfnB1sd1uOcZlmhD4@nongnu.org
X-Gm-Message-State: AOJu0YwYpyq6MKd1C96Y7CEnhk5xOBZ046dw6d+y7q8RC1AcjjNF3Ik+
 akVbNrLsKkeDtO/ianUy6ok6OrxoXgqwkw1LzE+qPm7SPICReUnRjmhnYmztZoGOHTF6JvYFiDt
 V5IeyqDs66EnUxMN2CYzrSF9dOx1qSFhz3CGpnfNsUUYe6vKY3p74nritGbAX9Atf4te8XocRPQ
 0XCq38tZI9bKu3CZ13rsCfqR0JRwrjv0NBJ1xBg5np1j5g
X-Gm-Gg: AY/fxX7BDuEG8//ltIe2OnYencrh/mLLTcOx8DQ/dBU3VJqwaryJ5wP6lGs86Kcb3Jj
 VqAc/iasQHEZQoV7goVBzNBe8IpCliO8K8ghFPniXNmf/NIKFlPz5U1fqLCkD/5HaoG9r/sqAiu
 PjOyZYxlvfCaVcwfeFLuT72gi28xMOATh5ZA6SsP5GhMgQ472KntnzhLyYvAGgVPWOQA==
X-Received: by 2002:a05:6102:548d:b0:5ef:7221:aa9b with SMTP id
 ada2fe7eead31-5ef7230f1aemr5004590137.18.1768277177461; 
 Mon, 12 Jan 2026 20:06:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwbqw1gERFoObMVOXOkU5UdoMgwhKXDiK0ZUHLFyGwW4Fhtz7CTMMKRVKjA61u3dNd1HvrS8O2+K5bPcaFR+I=
X-Received: by 2002:a05:6102:548d:b0:5ef:7221:aa9b with SMTP id
 ada2fe7eead31-5ef7230f1aemr5004573137.18.1768277176838; Mon, 12 Jan 2026
 20:06:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 20:06:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 20:06:16 -0800
From: Alexander Bulekov <alxndr@bu.edu>
References: <CAHUE=o9+kYVzWmHbHkJ5FKDpJhekhBCW8j+vwFm0yQCJrQGveA@mail.gmail.com>
 <20251112003637.1984547-1-navidem@google.com>
 <20251112003637.1984547-2-navidem@google.com>
 <CAHUE=o8u1snmMBGHExoZix3vFY6Y8J_jWdYKNDiuMd6jvw0qzQ@mail.gmail.com>
 <aV0EtXyfCmpSUvg8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <aV0EtXyfCmpSUvg8@redhat.com>
Date: Mon, 12 Jan 2026 20:06:16 -0800
X-Gm-Features: AZwV_QjYNle8vUh4vivPrxMNUHGUceeFixiUKUDemrBIfdiAh9unotlpirAgddU
Message-ID: <CAHUE=o_F=b3PHZQjZ_tA5gVDPXF_FixZ5na5ymxZWkBy_oEZtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] tests/qtest/fuzz: Add generic fuzzer for VNC
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Navid Emamdoost <navidem@google.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, 
 stefanha@redhat.com, farosas@suse.de, darren.kenny@oracle.com, 
 Qiuhao.Li@outlook.com, lvivier@redhat.com, zsm@google.com, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.71.140.199; envelope-from=alxndr@bu.edu;
 helo=esa14.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 260106 1249, Daniel P. Berrang=C3=A9 wrote:
> Hi Alexander,
>
> I don't see this old fuzzing patch merged yet. Who is normally collecting
> and merging fuzz patches ?

Hi Daniel,
In the past, as far as I remember it has been either me or Thomas. I can
put together the pull-req. Apologies for the delay

>
> On Fri, Nov 14, 2025 at 09:02:06AM -0600, Alexander Bulekov wrote:
> > On 251112 0036, Navid Emamdoost wrote:
> > > Add a new generic fuzz target for the QEMU VNC server. This target
> > > exercises both the standard VNC protocol and the VNC-over-WebSocket
> > > transport layer, increasing coverage of a primary remote attack surfa=
ce.
> > >
> > > To support parallel fuzzing (e.g., with oss-fuzz), the VNC unix
> > > socket paths are generated dynamically. The fuzzer harness inspects t=
he
> > > command line for placeholders and replaces them with unique paths
> > > created by mkstemp() before execution.
> > >
> > > ---
> > >
> > > This new target increases code coverage in the VNC subsystem
> > > and related networking and I/O code.
> > > The baseline coverage below was generated by running all existing fuz=
z
> > > targets with the oss-fuzz corpus. The new target shows significant ga=
ins:
> > >
> > > ---------------------------------------------------------------------=
-------
> > > File                       New Target                Baseline        =
Change
> > > ---------------------------------------------------------------------=
-------
> > > vnc.c                      339/3212 (10.6%)     3/3212 (0.1%)        =
+336
> > > keymaps.c                  91/184 (49.5%)       0/184 (0.0%)         =
+91
> > > net-listener.c             76/198 (38.4%)       3/198 (1.5%)         =
+73
> > > channel-socket.c           73/575 (12.7%)       19/575 (3.3%)        =
+54
> > > qemu-sockets.c             44/1019 (4.3%)       0/1019 (0.0%)        =
+44
> > > vnc-jobs.c                 41/219 (18.7%)       0/219 (0.0%)         =
+41
> > > dns-resolver.c             28/145 (19.3%)       3/145 (2.1%)         =
+25
> > >
> > > Signed-off-by: Navid Emamdoost <navidem@google.com>
> >
> > Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
> >
> > > ---
> > >  tests/qtest/fuzz/generic_fuzz_configs.h | 50 +++++++++++++++++++++++=
++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fu=
zz/generic_fuzz_configs.h
> > > index ef0ad95712..9c46e106a4 100644
> > > --- a/tests/qtest/fuzz/generic_fuzz_configs.h
> > > +++ b/tests/qtest/fuzz/generic_fuzz_configs.h
> > > @@ -29,6 +29,52 @@ static inline gchar *generic_fuzzer_virtio_9p_args=
(void){
> > >      "writeout=3Dimmediate,fmode=3D0600,dmode=3D0700", tmpdir);
> > >  }
> > >
> > > +/*
> > > + * Global variables and cleanup handler for VNC fuzzer sockets.
> > > + * These are needed because the socket paths must be available at ex=
it.
> > > + */
> > > +static char g_vnc_socket_path[sizeof("/tmp/qemu-vnc.XXXXXX")];
> > > +static char g_vnc_ws_socket_path[sizeof("/tmp/qemu-vnc-ws.XXXXXX")];
> > > +
> > > +static void cleanup_vnc_sockets(void)
> > > +{
> > > +    if (g_vnc_socket_path[0] !=3D '\0') {
> > > +        unlink(g_vnc_socket_path);
> > > +    }
> > > +    if (g_vnc_ws_socket_path[0] !=3D '\0') {
> > > +        unlink(g_vnc_ws_socket_path);
> > > +    }
> > > +}
> > > +
> > > +/*
> > > + * Dynamically generate VNC arguments with unique unix socket paths.
> > > + * This allows multiple fuzzing jobs to run in parallel without conf=
lict.
> > > + */
> > > +static inline gchar *generic_fuzzer_vnc_args(void)
> > > +{
> > > +    static bool cleanup_registered =3D false;
> > > +    int fd;
> > > +
> > > +    strcpy(g_vnc_socket_path, "/tmp/qemu-vnc.XXXXXX");
> > > +    fd =3D g_mkstemp(g_vnc_socket_path);
> > > +    g_assert_cmpint(fd, !=3D, -1);
> > > +    close(fd);
> > > +
> > > +    strcpy(g_vnc_ws_socket_path, "/tmp/qemu-vnc-ws.XXXXXX");
> > > +    fd =3D g_mkstemp(g_vnc_ws_socket_path);
> > > +    g_assert_cmpint(fd, !=3D, -1);
> > > +    close(fd);
> > > +
> > > +    if (!cleanup_registered) {
> > > +        atexit(cleanup_vnc_sockets);
> > > +        cleanup_registered =3D true;
> > > +    }
> > > +
> > > +    return g_strdup_printf("-machine q35 -nodefaults "
> > > +                           "-vnc vnc=3Dunix:%s,websocket=3Dunix:%s",
> > > +                           g_vnc_socket_path, g_vnc_ws_socket_path);
> > > +}
> > > +
> > >  const generic_fuzz_config predefined_configs[] =3D {
> > >      {
> > >          .name =3D "virtio-net-pci-slirp",
> > > @@ -247,6 +293,10 @@ const generic_fuzz_config predefined_configs[] =
=3D {
> > >          .args =3D "-machine q35 -nodefaults "
> > >          "-parallel file:/dev/null",
> > >          .objects =3D "parallel*",
> > > +    },{
> > > +        .name =3D "vnc",
> > > +        .argfunc =3D generic_fuzzer_vnc_args,
> > > +        .objects =3D "*",
> > >      }
> > >  };
> > >
> > > --
> > > 2.51.2.1041.gc1ab5b90ca-goog
> > >
> > >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

