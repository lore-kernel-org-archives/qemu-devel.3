Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB50C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 13:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWabu-0003JT-IV; Tue, 01 Jul 2025 09:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uWabX-0003Fo-Lx
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uWabV-0000wv-Ab
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 09:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751374848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fYfM940a/iaS5pFWzLvFRCx0mGuBpNaDNDqEihA+GK8=;
 b=a3QBEzhCefIYN+T7nQbjZFa3XlPBokdCQcMiyoiAv+Tyi/Df3ofJIwPq+vpPa6aha5Kb1I
 DkZHWv/pnvt4b27mCR/lXcQZDiAyKxM/1fFkQYVqBJnkfr1BldxMsngUZ7c9M8ji7/RfGu
 pieAZ7q93hJlCsCgIlMQwHaoroWNEY8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-caTznrjKNduDG156lMtRMw-1; Tue, 01 Jul 2025 09:00:47 -0400
X-MC-Unique: caTznrjKNduDG156lMtRMw-1
X-Mimecast-MFC-AGG-ID: caTznrjKNduDG156lMtRMw_1751374846
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so1993097f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 06:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751374846; x=1751979646;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fYfM940a/iaS5pFWzLvFRCx0mGuBpNaDNDqEihA+GK8=;
 b=WHgDkmvMMjC597ikpCSXY9qD7nrVUYzAayeF2oginQNSgmBvYgrvHlcxdcEXXH67n3
 TMqdWEALnhZ1Itv5ii/3Bwu9ppv8VLPA3xInFaTCn6fynIKRU5NLm34JcfdDyQdGe7sm
 JYVmJuGTyMnoN+vejoqYm0Y0pnsqThg4QwuT5FXqlYtWdB/Y23b95+EvPAho9+Uy5hW0
 NcRln4z7pPfF2epHrfo3NupKUt8lmqtL+uMbdIl/t9FaQk3+4RUqHycO39ktY4Q2jIgN
 RKQJE8YXzF79W2uNsG0W8d7UrkBWh4Wjbsio2YpChOmDu4LGwOU/VFfX/E4McPGBm/ct
 d46Q==
X-Gm-Message-State: AOJu0YzhYf5vbsPG2o2RbjMsiQJJ/AK0WvnAbX5jmV0SvjEqg/0MH4Zh
 iS5MetI6MbXga+Bc9bFgqfA+VrU8qG2XqHv01BGJFerfvE/Flya5RWp1VgbpqPcdy++pM32+sSi
 QR6aXidlaTmn4lJdn6Ud30QpAQM6Xg4JpkxIMd48a3h9is2lp+kdOs3sv
X-Gm-Gg: ASbGncvTNwrGfNqivWZaai9hnewErjDgm1y3S2jkfa3RLM/0ztSDFd8urxcCC39n9PD
 I4VQfDJWLWBjn7HUN9YLD5SB4yyimUtdCjkOroR5Fzm53Cc7HyGUUNyNcvmxzTo513eEddyUqPP
 yOWdSRKquwJUwybVRL9PnHbat3eM06TCv7iopN1H6PN/zmr3jnTdFajuE9a1sHljle4fsnfzXqP
 dSHZBwBkw2O+/+X5WN3E6nTsrbaxR690GQX+5z041+by36XGmjV7q2sRQK0xjR0VgSt7G5+8eJf
 hGUrHx5AQRU+gPetqasyR7YAORAhlaNzEbh/gmOqjqNnMMuREPON70jxAZyUQg==
X-Received: by 2002:a05:6000:25e2:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3a8e833b6admr13277559f8f.0.1751374844406; 
 Tue, 01 Jul 2025 06:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGemXcAhejiIrvSWGR8qUKYl12C4Ahxt67ZrsvMKZiP3cYOdiJCEPq57YrXXV3MVPAfCgUZ3Q==
X-Received: by 2002:a05:6000:25e2:b0:3a4:f7e3:c63c with SMTP id
 ffacd0b85a97d-3a8e833b6admr13277440f8f.0.1751374843538; 
 Tue, 01 Jul 2025 06:00:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823c463asm194845745e9.39.2025.07.01.06.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 06:00:43 -0700 (PDT)
Message-ID: <48ce7ba4-882e-4e6b-801a-135d489ae7f0@redhat.com>
Date: Tue, 1 Jul 2025 15:00:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <CACGkMEvcC7jv9LN5bP61E0OgSBENswotm+3fq8NAg3wBC9vUEQ@mail.gmail.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <CACGkMEvcC7jv9LN5bP61E0OgSBENswotm+3fq8NAg3wBC9vUEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 01/07/2025 03:46, Jason Wang wrote:
> On Wed, Jun 18, 2025 at 11:58 PM Laurent Vivier <lvivier@redhat.com> wrote:
>>
>> This commit introduces support for passt as a new network backend.
>> passt is an unprivileged, user-mode networking solution that provides
>> connectivity for virtual machines by launching an external helper process.
>>
>> The implementation reuses the generic stream data handling logic. It
>> launches the passt binary using GSubprocess, passing it a file
>> descriptor from a socketpair() for communication. QEMU connects to
>> the other end of the socket pair to establish the network data stream.
>>
>> The PID of the passt daemon is tracked via a temporary file to
>> ensure it is terminated when QEMU exits.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hmp-commands.hx   |   3 +
>>   meson.build       |   6 +
>>   meson_options.txt |   2 +
>>   net/clients.h     |   4 +
>>   net/hub.c         |   3 +
>>   net/meson.build   |   3 +
>>   net/net.c         |   4 +
>>   net/passt.c       | 434 ++++++++++++++++++++++++++++++++++++++++++++++
>>   qapi/net.json     | 124 +++++++++++++
>>   qemu-options.hx   |  18 ++
>>   10 files changed, 601 insertions(+)
>>   create mode 100644 net/passt.c
>>
...
>> +static int net_passt_start_daemon(NetPasstState *s, int sock, Error **errp)
>> +{
>> +    g_autoptr(GSubprocess) daemon = NULL;
>> +    g_autofree gchar *contents = NULL;
>> +    g_autoptr(GError) error = NULL;
>> +    GSubprocessLauncher *launcher;
>> +
>> +    qemu_set_info_str(&s->data.nc, "launching passt");
>> +
>> +    launcher = g_subprocess_launcher_new(G_SUBPROCESS_FLAGS_NONE);
>> +    g_subprocess_launcher_take_fd(launcher, sock, 3);
>> +
>> +    daemon =  g_subprocess_launcher_spawnv(launcher,
>> +                                           (const gchar *const *)s->args->pdata,
>> +                                           &error);
> 
> I wonder if such launching is a must or at least we should allow
> accepting fd from the management layer (e.g in the case that execve()
> is restricted)?

In this case, the user should use the existing interface: externally start passt and use 
"-netdev vhost-user" or '-netdev stream'. It's already managed by libvirt. I think this is 
a case we shouldn't manage here.

>> +    g_object_unref(launcher);
>> +
>> +    if (!daemon) {
>> +        error_setg(errp, "Error creating daemon: %s", error->message);
>> +        return -1;
>> +    }
>> +
>> +    if (!g_subprocess_wait(daemon, NULL, &error)) {
>> +        error_setg(errp, "Error waiting for daemon: %s", error->message);
>> +        return -1;
>> +    }
>> +
>> +    if (g_subprocess_get_if_exited(daemon) &&
>> +        g_subprocess_get_exit_status(daemon)) {
>> +        return -1;
>> +    }
>> +
>> +    if (!g_file_get_contents(s->pidfile, &contents, NULL, &error)) {
>> +        error_setg(errp, "Cannot read passt pid: %s", error->message);
>> +        return -1;
>> +    }
>> +
>> +    s->pid = (pid_t)g_ascii_strtoll(contents, NULL, 10);
>> +    if (s->pid <= 0) {
>> +        error_setg(errp, "File '%s' did not contain a valid PID.", s->pidfile);
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
> 
> ...
> 
>> +    if (net_passt_stream_start(s, errp) == -1) {
>> +        qemu_del_net_client(nc);
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 97ea1839813b..76d7654414f7 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -112,6 +112,125 @@
>>     'data': {
>>       'str': 'str' } }
>>
>> +##
>> +# @NetDevPasstOptions:
>> +#
>> +# Unprivileged user-mode network connectivity using passt
>> +#
>> +# @path: path to passt binary
>> +#
>> +# @quiet: don't print informational messages
>> +#
>> +# @debug: be verbose
>> +#
>> +# @trace: extra verbose
>> +#
>> +# @vhost-user: enable vhost-user
>> +#
>> +# @pcap-file: log traffic to pcap file
>> +#
>> +# @mtu: assign MTU via DHCP/NDP
>> +#
>> +# @address: IPv4 or IPv6 address
>> +#
>> +# @netmask: IPv4 mask
>> +#
>> +# @mac: source MAC address
>> +#
>> +# @gateway: IPv4 or IPv6 address as gateway
>> +#
>> +# @interface: interface for addresses and routes
>> +#
>> +# @outbound: bind to address as outbound source
>> +#
>> +# @outbound-if4: bind to outbound interface for IPv4
>> +#
>> +# @outbound-if6: bind to outbound interface for IPv6
>> +#
>> +# @dns: IPv4 or IPv6 address as DNS
>> +#
>> +# @search: search domains
>> +#
>> +# @fqdn: FQDN to configure client with
>> +#
>> +# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
>> +#
>> +# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
>> +#
>> +# @map-host-loopback: addresse to refer to host
>> +#
>> +# @map-guest-addr: addr to translate to guest's address
>> +#
>> +# @dns-forward: forward DNS queries sent to
>> +#
>> +# @dns-host: host nameserver to direct queries to
>> +#
>> +# @tcp: enable/disable TCP
>> +#
>> +# @udp: enable/disable UDP
>> +#
>> +# @icmp: enable/disable ICMP
>> +#
>> +# @dhcp: enable/disable DHCP
>> +#
>> +# @ndp: enable/disable NDP
>> +#
>> +# @dhcpv6: enable/disable DHCPv6
>> +#
>> +# @ra: enable/disable route advertisements
>> +#
>> +# @freebind: bind to any address for forwarding
>> +#
>> +# @ipv4: enable/disable IPv4
>> +#
>> +# @ipv6: enable/disable IPv6
>> +#
>> +# @tcp-ports: TCP ports to forward
>> +#
>> +# @udp-ports: UDP ports to forward
>> +#
>> +# Since: 10.1
>> +##
>> +{ 'struct': 'NetDevPasstOptions',
>> +  'data': {
>> +    '*path':               'str',
>> +    '*quiet':              'bool',
>> +    '*debug':              'bool',
>> +    '*trace':              'bool',
>> +    '*vhost-user':         'bool',
>> +    '*pcap-file':          'str',
>> +    '*mtu':                'int',
>> +    '*address':            'str',
>> +    '*netmask':            'str',
>> +    '*mac':                'str',
>> +    '*gateway':            'str',
>> +    '*interface':          'str',
>> +    '*outbound':           'str',
>> +    '*outbound-if4':       'str',
>> +    '*outbound-if6':       'str',
>> +    '*dns':                'str',
>> +    '*search':             ['String'],
>> +    '*fqdn':               'str',
>> +    '*dhcp-dns':           'bool',
>> +    '*dhcp-search':        'bool',
>> +    '*map-host-loopback':  'str',
>> +    '*map-guest-addr':     'str',
>> +    '*dns-forward':        'str',
>> +    '*dns-host':           'str',
>> +    '*tcp':                'bool',
>> +    '*udp':                'bool',
>> +    '*icmp':               'bool',
>> +    '*dhcp':               'bool',
>> +    '*ndp':                'bool',
>> +    '*dhcpv6':             'bool',
>> +    '*ra':                 'bool',
>> +    '*freebind':           'bool',
>> +    '*ipv4':               'bool',
>> +    '*ipv6':               'bool',
>> +    '*tcp-ports':          ['String'],
>> +    '*udp-ports':          ['String'] },
>> +    'if': 'CONFIG_PASST' }
> 
> I would like to know the plan to support migration and its
> compatibility for passt.

As I said, the goal of this series is to be able to use '-nic passt' as we can use '-nic 
user'. '-nic user' supports migration but TCP connections are lost.

With this series '-nic passt' supports migration but TCP connections are lost.

But we can improve '-nic passt' because we can migrate TCP connections too, for that we 
need to launch passt-repair and to use vhost-user, if we really want to do this it can be 
added (with a 'migration=on' parameter?)... but it's also already managed by '-netdev 
vhost-user' and passt started manually or by libvirt.

Thanks,
Laurent


