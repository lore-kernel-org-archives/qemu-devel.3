Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E696D15DAD
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqhF-0004Rl-B6; Wed, 03 Dec 2025 12:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1vQqh2-0004JX-FE
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:31:09 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan.weil@weilnetz.de>)
 id 1vQqgv-0006zU-KE
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:31:07 -0500
Received: from [172.18.238.38] (ip-185-104-138-58.ptr.icomera.net
 [185.104.138.58])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 7BFCADA0747;
 Wed, 03 Dec 2025 18:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weilnetz.de; s=dkim1; 
 t=1764783057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zOVnAJyaKX6jNACwrSJyJC5VFGyXkzXAekSfo5AYjfA=;
 b=cAAidvPZZ/tAIV0Vp5MH6iNG/ShBVAOcBQRuqDGzSVOCo2xuWsZUqPasLVshg496YgcSJr
 gZudEV1lM7xs1H2ihBylnaIJT1HnLV4lFr4qhRnfCBdrOBGS8bpISmDkRw4jrw8eQrt4yK
 rOk+60oJnhHv5sEH8c3TMFB0S9A7agc=
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=stefan.weil@weilnetz.de
 smtp.mailfrom=stefan.weil@weilnetz.de
Message-ID: <b6d045ca-5565-46e1-99ed-737c35874d40@weilnetz.de>
Date: Wed, 3 Dec 2025 18:30:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL V2 12/16] net: Add passt network backend
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>
References: <20250715043524.21719-1-jasowang@redhat.com>
 <20250715043524.21719-13-jasowang@redhat.com>
Autocrypt: addr=stefan.weil@weilnetz.de; keydata=
 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
In-Reply-To: <20250715043524.21719-13-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: v2201612906741603
X-Rspamd-Queue-Id: 7BFCADA0747
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.10 / 12.00]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_ZERO(0.00)[0]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[weilnetz.de:s=dkim1];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[meson.build:url]
X-Rspamd-Action: no action
Received-SPF: pass client-ip=37.120.169.71;
 envelope-from=stefan.weil@weilnetz.de; helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Stefan Weil <stefan.weil@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 15.07.25 um 06:35 schrieb Jason Wang:
> From: Laurent Vivier <lvivier@redhat.com>
> 
> This commit introduces support for passt as a new network backend.
> passt is an unprivileged, user-mode networking solution that provides
> connectivity for virtual machines by launching an external helper process.
> 
> The implementation reuses the generic stream data handling logic. It
> launches the passt binary using GSubprocess, passing it a file
> descriptor from a socketpair() for communication. QEMU connects to
> the other end of the socket pair to establish the network data stream.
> 
> The PID of the passt daemon is tracked via a temporary file to
> ensure it is terminated when QEMU exits.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   docs/system/devices/net.rst   |  40 +++-
>   hmp-commands.hx               |   3 +
>   meson.build                   |   6 +
>   meson_options.txt             |   2 +
>   net/clients.h                 |   4 +
>   net/hub.c                     |   3 +
>   net/meson.build               |   3 +
>   net/net.c                     |   4 +
>   net/passt.c                   | 407 ++++++++++++++++++++++++++++++++++
>   qapi/net.json                 | 115 ++++++++++
>   qemu-options.hx               | 145 +++++++++++-
>   scripts/meson-buildoptions.sh |   3 +
>   12 files changed, 731 insertions(+), 4 deletions(-)
>   create mode 100644 net/passt.c
> 
[...]

> +# @dhcp-dns: enable/disable DNS list in DHCP/DHCPv6/NDP
> +#
> +# @dhcp-search: enable/disable list in DHCP/DHCPv6/NDP
> +#
> +# @map-host-loopback: addresse to refer to host
> +#
> +# @map-guest-addr: addr to translate to guest's address
> +#
> +# @dns-forward: forward DNS queries sent to
> +#
> +# @dns-host: host nameserver to direct queries to
> +#
> +# @tcp: enable/disable TCP
> +#
> +# @udp: enable/disable UDP
> +#
> +# @icmp: enable/disable ICMP
> +#
> +# @dhcp: enable/disable DHCP
> +#
> +# @ndp: enable/disable NDP
> +#
> +# @dhcpv6: enable/disable DHCPv6
> +#
> +# @ra: enable/disable route advertisements
> +#
> +# @freebind: bind to any address for forwarding
> +#
> +# @ipv4: enable/disable IPv4
> +#
> +# @ipv6: enable/disable IPv6
> +#
> +# @tcp-ports: TCP ports to forward
> +#
> +# @udp-ports: UDP ports to forward
> +#
> +# @param: parameter to pass to passt command
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'NetDevPasstOptions',
> +  'data': {
> +    '*path':               'str',
> +    '*quiet':              'bool',
> +    '*mtu':                'int',
> +    '*address':            'str',
> +    '*netmask':            'str',
> +    '*mac':                'str',
> +    '*gateway':            'str',
> +    '*interface':          'str',
> +    '*outbound':           'str',
> +    '*outbound-if4':       'str',
> +    '*outbound-if6':       'str',
> +    '*dns':                'str',
> +    '*search':             ['String'],
> +    '*fqdn':               'str',
> +    '*dhcp-dns':           'bool',
> +    '*dhcp-search':        'bool',
> +    '*map-host-loopback':  'str',
> +    '*map-guest-addr':     'str',
> +    '*dns-forward':        'str',
> +    '*dns-host':           'str',
> +    '*tcp':                'bool',
> +    '*udp':                'bool',
> +    '*icmp':               'bool',
> +    '*dhcp':               'bool',
> +    '*ndp':                'bool',
> +    '*dhcpv6':             'bool',
> +    '*ra':                 'bool',
> +    '*freebind':           'bool',
> +    '*ipv4':               'bool',
> +    '*ipv6':               'bool',
> +    '*tcp-ports':          ['String'],
> +    '*udp-ports':          ['String'],
> +    '*param':             ['String'] },
> +    'if': 'CONFIG_PASST' }
> +
>   ##
>   # @NetdevUserOptions:
>   #
> @@ -729,12 +839,15 @@
>   #
>   # @af-xdp: since 8.2
>   #
> +# @passt: since 10.1
> +#
>   # Since: 2.7
>   ##
>   { 'enum': 'NetClientDriver',
>     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'stream',
>               'dgram', 'vde', 'bridge', 'hubport', 'netmap', 'vhost-user',
>               'vhost-vdpa',
> +            { 'name': 'passt', 'if': 'CONFIG_PASST' },
>               { 'name': 'af-xdp', 'if': 'CONFIG_AF_XDP' },
>               { 'name': 'vmnet-host', 'if': 'CONFIG_VMNET' },
>               { 'name': 'vmnet-shared', 'if': 'CONFIG_VMNET' },
> @@ -756,6 +869,8 @@
>     'discriminator': 'type',
>     'data': {
>       'nic':      'NetLegacyNicOptions',
> +    'passt':    { 'type': 'NetDevPasstOptions',
> +                  'if': 'CONFIG_PASST' },
>       'user':     'NetdevUserOptions',
>       'tap':      'NetdevTapOptions',
>       'l2tpv3':   'NetdevL2TPv3Options',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 1f862b19a6..e8252cd5e8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2796,6 +2796,24 @@ DEFHEADING()
>   DEFHEADING(Network options:)
>   
>   DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
> +#ifdef CONFIG_PASST
> +    "-netdev passt,id=str[,path=file][,quiet=on|off]\n"
> +    "[,mtu=mtu][,address=addr][,netmask=mask][,mac=addr][,gateway=addr]\n"
> +    "          [,interface=name][,outbound=address][,outbound-if4=name]\n"
> +    "          [,outbound-if6=name][,dns=addr][,search=list][,fqdn=name]\n"
> +    "          [,dhcp-dns=on|off][,dhcp-search=on|off][,map-host-loopback=addr]\n"
> +    "          [,map-guest-addr=addr][,dns-forward=addr][,dns-host=addr]\n"
> +    "          [,tcp=on|off][,udp=on|off][,icmp=on|off][,dhcp=on|off]\n"
> +    "          [,ndp=on|off][,dhcpv6=on|off][,ra=on|off][,freebind=on|off]\n"
> +    "          [,ipv4=on|off][,ipv6=on|off][,tcp-ports=spec][,udp-ports=spec]\n"
> +    "          [,param=list]\n"
> +    "                configure a passt network backend with ID 'str'\n"
> +    "                if 'path' is not provided 'passt' will be started according to PATH\n"
> +    "                by default, informational message of passt are not displayed (quiet=on)\n"
> +    "                to display this message, use 'quiet=off'\n"
> +    "                for details on other options, refer to passt(1)\n"
> +    "                'param' allows to pass any option defined by passt(1)\n"
> +#endif
>   #ifdef CONFIG_SLIRP
>       "-netdev user,id=str[,ipv4=on|off][,net=addr[/mask]][,host=addr]\n"
>       "         [,ipv6=on|off][,ipv6-net=addr[/int]][,ipv6-host=addr]\n"
> @@ -2952,6 +2970,9 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>       "                configure a hub port on the hub with ID 'n'\n", QEMU_ARCH_ALL)
>   DEF("nic", HAS_ARG, QEMU_OPTION_nic,
>       "-nic [tap|bridge|"
> +#ifdef CONFIG_PASST
> +    "passt|"
> +#endif
>   #ifdef CONFIG_SLIRP
>       "user|"
>   #endif
> @@ -2984,6 +3005,9 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
>       "                configure or create an on-board (or machine default) NIC and\n"
>       "                connect it to hub 0 (please use -nic unless you need a hub)\n"
>       "-net ["
> +#ifdef CONFIG_PASST
> +    "passt|"
> +#endif
>   #ifdef CONFIG_SLIRP
>       "user|"
>   #endif
> @@ -3005,7 +3029,7 @@ DEF("net", HAS_ARG, QEMU_OPTION_net,
>       "                old way to initialize a host network interface\n"
>       "                (use the -netdev option if possible instead)\n", QEMU_ARCH_ALL)
>   SRST
> -``-nic [tap|bridge|user|l2tpv3|vde|netmap|af-xdp|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
> +``-nic [tap|passt|bridge|user|l2tpv3|vde|netmap|af-xdp|vhost-user|socket][,...][,mac=macaddr][,model=mn]``
>       This option is a shortcut for configuring both the on-board
>       (default) guest NIC hardware and the host network backend in one go.
>       The host backend options are the same as with the corresponding
> @@ -3027,6 +3051,123 @@ SRST
>       network backend) which is activated if no other networking options
>       are provided.
>   
> +``-netdev passt,id=str[,option][,...]``
> +    Configure a passt network backend which requires no administrator
> +    privilege to run. Valid options are:
> +
> +    ``id=id``
> +        Assign symbolic name for use in monitor commands.
> +
> +    ``path=file``
> +        Filename of the passt program to run. If it is not provided,
> +        passt command will be started with the help of the PATH environment
> +        variable.
> +
> +    ``quiet=on|off``
> +        By default, ``quiet=on`` to disable informational message from
> +        passt. ``quiet=on`` is passed as ``--quiet`` to passt.
> +
> +    ``@mtu``
> +        Assign MTU via DHCP/NDP
> +
> +    ``address``
> +        IPv4 or IPv6 address
> +
> +    ``netmask``
> +        IPv4 mask
> +
> +    ``mac``
> +        source MAC address
> +
> +    ``gateway``
> +        IPv4 or IPv6 address as gateway
> +
> +    ``interface``
> +        Interface for addresses and routes
> +
> +    ``outbound``
> +        Bind to address as outbound source
> +
> +    ``outbound-if4``
> +        Bind to outbound interface for IPv4
> +
> +    ``outbound-if6``
> +        Bind to outbound interface for IPv6
> +
> +    ``dns``
> +        IPv4 or IPv6 address as DNS
> +
> +    ``search``
> +        Search domains
> +
> +    ``fqdn``
> +        FQDN to configure client with
> +
> +    ``dhcp-dns``
> +        Enable/disable DNS list in DHCP/DHCPv6/NDP
> +
> +    ``dhcp-search``
> +        Enable/disable list in DHCP/DHCPv6/NDP
> +
> +    ``map-host-loopback``
> +        Addresse to refer to host

Should this be "Address" (and a simmilar comment fix above)?

I just checked the spelling of the latest documentation ...


Regards,
Stefan


