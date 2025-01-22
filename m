Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B7C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadzH-0005Of-44; Wed, 22 Jan 2025 11:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tadzG-0005OW-2B
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:53:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1tadzE-00082S-5a
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:53:53 -0500
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mcp3E-1t28B62WXK-00djja; Wed, 22 Jan 2025 17:53:38 +0100
Message-ID: <fa016fb1-1f24-4e03-876e-58b4a0296962@vivier.eu>
Date: Wed, 22 Jan 2025 17:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
To: deller@kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Cc: deller@gmx.de
References: <20250120213340.359195-1-deller@kernel.org>
 <20250120213340.359195-2-deller@kernel.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20250120213340.359195-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QjXluLbBg+dzi5atChnSkiyG5NAOT+d3zVVJjHVLIzpTa8+Es4O
 3LH/71c+URMZQMul3XYdJo2WRgGYERZgZX5ZBNTqWegvZKbgya3W5QoQmOvwlAULcIm1MgP
 h3UxwJ1tVaOgL8WtnCP6e133a1h50YqxFAQI9grjOtbopIv8MuiQpiZW7WY/bEdnYmx4lUf
 Ah8AQt0W/sX7NpgVnCWag==
UI-OutboundReport: notjunk:1;M01:P0:LkFTDH6lfzA=;+f9i3oifD8pi3xc9OD9i82hwjLW
 f8vY8gAdcF0QhWjeBmGZ5O0Jgcqh+j7t0+NfXN8dVrxX6EFrNKtSruy3nxcEYNb2oYqcCMALx
 fvKMAP1N0H43E80JlMud5m4Hmq+nF4sU7pf3pVmZAShBHNH4W0uNxEa4hZw/vMZKtU30aTh6P
 SoZ3EehpB7CfZ0kMaC6c7rxZjMvuu+j/WzCxH/VZWugnoI6WFV1iqpKdbqT0xL+PgxbRzeagR
 hvd211y5VPKXXxtpqHUstxLQnh6ev13nBUO/MtgLgulBDGqSNonzDzxKY7x6NWbqJj7x+UoC/
 /SAzK+zfZU6/W8QMrKLQzTU02DR/Xy69OT85NlhZrTZCKAjN0O/oIuBbHzyE261rUuFppgOI5
 7cZc0zCLGOsBDFHgKer6Jg5Y30AygAaskdBki8k4uKYPtEy6T97j9bM6yLDmfAu19j+3JDXu1
 iPcArk6FutLkTMJG5bI4By/nkGGPndZVtI/BJkY3IufBdsoGEJSsEWhzpsP3PzBKCK2eXf6mH
 dsjVKzxLYPrwiHwBagvjEguV3o7YegB00bkspZuxe0asZYJnh0+aAE1z0E9bK/gcjYy5lDClo
 OBd0oRfk5FSSjCVc1T4oUP/u6TnfNMQVAGclQxPaGA06xpPe4WQM2drz1xG/DksJEez0vGCUt
 1u6+Lx2S6+EouZlE860IJQa79F4y4tLIr4p3caVNw+BBZt8B2AFGYSIw+381Bqgv82s4ms5t/
 qK2rnExxMQx6RfcfgYLln+JxL5+rkG10ukcad/DDOKycllqfUDx2hnT6AjbmdZOGjcGmUwGr8
 wniSMxgUg3Y/bKFrz58PaPsR3dDbqolbwpCFq98voLYF50lrN9P9QuMejhMaadJh8PxMtV1UL
 rqxg5D6IVck8CHi+C+dDsunlqz9Fpvb6Ei0rkBQcm1THZTJDBn8nFL1hrVwqfOSOqgh5ZAc/g
 SIfBIncdQkr+j8k45Jk7NwWbmJd4pZzpXpPAXwaqG89uyDdNSn8udhBbqhIhblJLD3p2pAWJJ
 aUSi2KpppR/Z5EJVVR/tBPVSlhkO9Tx8wIISXLlf0TqUBlN23dJ02VZ1YVz47S9eJUvqYaWLU
 HxGS+K+XefdwH6V0ggnwR5pPK37eMK2a0ezS5EMziYKd52cIhvGd//qhpjKlQuNIhjRBdmfxc
 =
Received-SPF: pass client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Le 20/01/2025 à 22:33, deller@kernel.org a écrit :
> From: Helge Deller <deller@gmx.de>
> 
> Fixes this warning:
>   Unknown host IFA type: 11
> 
> IFA_PROTO has been introduced in kernel v5.18, and as such using it
> unconditionally breaks build on Ubuntu 22.04.  Instead convert the IFA_XXX
> values to QEMU_IDA_XXX values and use those instead.
> Already existing IFA_XXX usages are converted to QEMU_IFA_XXX in a
> followup-patch.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/fd-trans.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index c04a97c73a..05a944b32e 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -31,6 +31,22 @@
>   #include "fd-trans.h"
>   #include "signal-common.h"
>   
> +enum {
> +    QEMU_IFA_UNSPEC,
> +    QEMU_IFA_ADDRESS,
> +    QEMU_IFA_LOCAL,
> +    QEMU_IFA_LABEL,
> +    QEMU_IFA_BROADCAST,
> +    QEMU_IFA_ANYCAST,
> +    QEMU_IFA_CACHEINFO,
> +    QEMU_IFA_MULTICAST,
> +    QEMU_IFA_FLAGS,
> +    QEMU_IFA_RT_PRIORITY,
> +    QEMU_IFA_TARGET_NETNSID,
> +    QEMU_IFA_PROTO,
> +    QEMU__IFA__MAX,
> +};
> +
>   enum {
>       QEMU_IFLA_BR_UNSPEC,
>       QEMU_IFLA_BR_FORWARD_DELAY,
> @@ -1140,6 +1156,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
>       /* binary: depends on family type */
>       case IFA_ADDRESS:
>       case IFA_LOCAL:
> +    case QEMU_IFA_PROTO:
>           break;
>       /* string */
>       case IFA_LABEL:

It would be cleaner to replace all the IFA_XXX by their QEMU_IFA_XXX.

Thanks,
Laurent

