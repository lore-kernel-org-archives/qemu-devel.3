Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B183C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 08:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Gbl-0001zd-AT; Fri, 26 Apr 2024 04:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.poetzsch@kernkonzept.com>)
 id 1s0Gbj-0001z7-Bq
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:06:59 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.poetzsch@kernkonzept.com>)
 id 1s0Gbg-0001cK-Hu
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 04:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=ApSt2iEjnXR5j18RXNxG42NXfRM4aQboqqc9ymi0FDk=; b=qCOn/sgzr2kxmst0ojd01I+vbc
 WSkF2OImvScKj83fSHK/tWQv8ZzSCmpX51jNoIJhsgyKqQgRDsc9nUBRoXuneRIYWMDvKXvXZ9uGU
 7nYsWlcioLl3MQ+7w6vUwdX4rPGE8GRj1A9jRttAYFkgkW4/IWUNaAv58r2oT2XikDjhorxsI9rYk
 X3w9yuFnBhrdGiqiAeOBDIQ03GhVpi8/s2J+6Li2nvfSH8C/mb5AoeLShheSPDXNkJoUHG5/b3waD
 kihmdQy0KhWCFhhdGIk0OkA5jzUYqCgLAhnlMDjhGpaMkcaIw17LxitB0CEkSFWYQj/nEuDul0MdU
 vlDX54ZQ==;
Received: from pd9fe93de.dip0.t-ipconnect.de ([217.254.147.222]
 helo=[192.168.2.26]) by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim 4.96)
 id 1s0Gbb-00F3RH-2E; Fri, 26 Apr 2024 10:06:51 +0200
Message-ID: <14b97cff-7fe9-464a-9005-eec4585b4b67@kernkonzept.com>
Date: Fri, 26 Apr 2024 10:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for abs info in vhost-user-input
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20240322102421.2158139-1-christian.poetzsch@kernkonzept.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
In-Reply-To: <20240322102421.2158139-1-christian.poetzsch@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=christian.poetzsch@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Ping. Anyone interested?

Thanks
Chris

On 3/22/24 11:24, Christian Pötzsch wrote:
> Absolute input device did not work, cause VIRTIO_INPUT_CFG_ABS_INFO is
> missing. Fetch this info when available and provide it to any virtio
> client.
> 
> This is basically the same code as in hw/input/virtio-input-host.c, just
> modified to work here.
> 
> Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
> ---
>   contrib/vhost-user-input/main.c | 46 +++++++++++++++++++++++++++++++--
>   1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
> index 081230da54..9506e34d04 100644
> --- a/contrib/vhost-user-input/main.c
> +++ b/contrib/vhost-user-input/main.c
> @@ -272,6 +272,32 @@ vi_bits_config(VuInput *vi, int type, int count)
>       g_array_append_val(vi->config, bits);
>   }
>   
> +static void
> +vi_input_abs_config(VuInput *vi, int axis)
> +{
> +    virtio_input_config config;
> +    struct input_absinfo absinfo;
> +    int rc;
> +
> +    rc = ioctl(vi->evdevfd, EVIOCGABS(axis), &absinfo);
> +    if (rc < 0) {
> +        return;
> +    }
> +
> +    memset(&config, 0, sizeof(config));
> +    config.select = VIRTIO_INPUT_CFG_ABS_INFO;
> +    config.subsel = axis;
> +    config.size   = sizeof(struct input_absinfo);
> +
> +    config.u.abs.min  = cpu_to_le32(absinfo.minimum);
> +    config.u.abs.max  = cpu_to_le32(absinfo.maximum);
> +    config.u.abs.fuzz = cpu_to_le32(absinfo.fuzz);
> +    config.u.abs.flat = cpu_to_le32(absinfo.flat);
> +    config.u.abs.res  = cpu_to_le32(absinfo.resolution);
> +
> +    g_array_append_val(vi->config, config);
> +}
> +
>   static char *opt_evdev;
>   static int opt_fdnum = -1;
>   static char *opt_socket_path;
> @@ -297,11 +323,12 @@ main(int argc, char *argv[])
>   {
>       GMainLoop *loop = NULL;
>       VuInput vi = { 0, };
> -    int rc, ver, fd;
> -    virtio_input_config id;
> +    int rc, ver, fd, i, axis;
> +    virtio_input_config id, *abs;
>       struct input_id ids;
>       GError *error = NULL;
>       GOptionContext *context;
> +    uint8_t byte;
>   
>       context = g_option_context_new(NULL);
>       g_option_context_add_main_entries(context, entries, NULL);
> @@ -375,6 +402,21 @@ main(int argc, char *argv[])
>       vi_bits_config(&vi, EV_ABS, ABS_CNT);
>       vi_bits_config(&vi, EV_MSC, MSC_CNT);
>       vi_bits_config(&vi, EV_SW,  SW_CNT);
> +
> +    abs = vi_find_config(&vi, VIRTIO_INPUT_CFG_EV_BITS, EV_ABS);
> +    if (abs) {
> +        for (i = 0; i < abs->size; i++) {
> +            byte = abs->u.bitmap[i];
> +            axis = 8 * i;
> +            while (byte) {
> +                if (byte & 1) {
> +                    vi_input_abs_config(&vi, axis);
> +                }
> +                axis++;
> +                byte >>= 1;
> +            }
> +        }
> +    }
>       g_debug("config length: %u", vi.config->len);
>   
>       if (opt_socket_path) {

-- 
http://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Geschäftsführer: Dr.-Ing. Michael Hohmuth

