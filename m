Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6550DE81A25
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs06T-00031x-FN; Mon, 16 Feb 2026 10:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs06P-00031Y-KO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:01:33 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vs06N-0007WJ-Jf
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9SrbTqxSMp5CfedlsFoO7DLkYnFX2xmyEezr3hTllyw=; b=mBJsjjXcU/xGgv8
 amGwZp0YGLZJzAUFjLzsCMBeUVVvZu2L9zq9cASw6IgKFWLheTSE1ufExtnT7AnRuuB7qFjJZNSqA
 LivGMJrDKWzz7mZXEDioQ+4hZPe6mHKoQZzgC7xcTyCjjtDfrFzgHfOA7glPkvUylmNtOnZamynuZ
 9w=;
Date: Mon, 16 Feb 2026 16:04:55 +0100
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, 
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, 
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng
Subject: Re: [PATCH v2 1/8] Hexagon (target/hexagon) Properly handle Hexagon
 CPU version
Message-ID: <aZMoaxVW2U7BokDu@hive.localdomain>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
 <20260215220422.212249-2-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260215220422.212249-2-ltaylorsimpson@gmail.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/02/26, Taylor Simpson wrote:
> Add the following CPU versions that were previously missing
>     v5
>     v55
>     v60
>     v61
>     v62
>     v65
> 
> Create an enum with the known Hexagon CPU versions
> Add a field to HexagonCPUClass to note the Hexagon CPU version
> 
> Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/cpu-qom.h | 23 +++++++++++++++++++++++
>  target/hexagon/cpu.h     |  2 ++
>  target/hexagon/cpu.c     | 28 ++++++++++++++++++++++------
>  3 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/target/hexagon/cpu-qom.h b/target/hexagon/cpu-qom.h
> index 0b149bd5fe..d2f98c683a 100644
> --- a/target/hexagon/cpu-qom.h
> +++ b/target/hexagon/cpu-qom.h
> @@ -11,11 +11,34 @@
>  
>  #include "hw/core/cpu.h"
>  
> +typedef enum {
> +    HEX_VER_NONE = 0x00,
> +    HEX_VER_V5 = 0x04,
> +    HEX_VER_V55 = 0x05,
> +    HEX_VER_V60 = 0x60,
> +    HEX_VER_V61 = 0x61,
> +    HEX_VER_V62 = 0x62,
> +    HEX_VER_V65 = 0x65,
> +    HEX_VER_V66 = 0x66,
> +    HEX_VER_V67 = 0x67,
> +    HEX_VER_V68 = 0x68,
> +    HEX_VER_V69 = 0x69,
> +    HEX_VER_V71 = 0x71,
> +    HEX_VER_V73 = 0x73,
> +    HEX_VER_ANY = 0xff,
> +} HexagonVersion;
> +
>  #define TYPE_HEXAGON_CPU "hexagon-cpu"
>  
>  #define HEXAGON_CPU_TYPE_SUFFIX "-" TYPE_HEXAGON_CPU
>  #define HEXAGON_CPU_TYPE_NAME(name) (name HEXAGON_CPU_TYPE_SUFFIX)
>  
> +#define TYPE_HEXAGON_CPU_V5 HEXAGON_CPU_TYPE_NAME("v5")
> +#define TYPE_HEXAGON_CPU_V55 HEXAGON_CPU_TYPE_NAME("v55")
> +#define TYPE_HEXAGON_CPU_V60 HEXAGON_CPU_TYPE_NAME("v60")
> +#define TYPE_HEXAGON_CPU_V61 HEXAGON_CPU_TYPE_NAME("v61")
> +#define TYPE_HEXAGON_CPU_V62 HEXAGON_CPU_TYPE_NAME("v62")
> +#define TYPE_HEXAGON_CPU_V65 HEXAGON_CPU_TYPE_NAME("v65")
>  #define TYPE_HEXAGON_CPU_V66 HEXAGON_CPU_TYPE_NAME("v66")
>  #define TYPE_HEXAGON_CPU_V67 HEXAGON_CPU_TYPE_NAME("v67")
>  #define TYPE_HEXAGON_CPU_V68 HEXAGON_CPU_TYPE_NAME("v68")
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 85afd59277..2b8e761c4d 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -117,6 +117,8 @@ typedef struct HexagonCPUClass {
>  
>      DeviceRealize parent_realize;
>      ResettablePhases parent_phases;
> +
> +    HexagonVersion hex_version;
>  } HexagonCPUClass;
>  
>  struct ArchCPU {
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 58a22ee41f..09a0de3c2f 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -27,12 +27,22 @@
>  #include "exec/gdbstub.h"
>  #include "accel/tcg/cpu-ops.h"
>  
> -static void hexagon_v66_cpu_init(Object *obj) { }
> -static void hexagon_v67_cpu_init(Object *obj) { }
> -static void hexagon_v68_cpu_init(Object *obj) { }
> -static void hexagon_v69_cpu_init(Object *obj) { }
> -static void hexagon_v71_cpu_init(Object *obj) { }
> -static void hexagon_v73_cpu_init(Object *obj) { }
> +#define HEX_CPU_INIT(NAME, VER) \
> +static void hexagon_##NAME##_cpu_init(Object *obj) \
> +{ HEXAGON_CPU_GET_CLASS(obj)->hex_version = VER; }
> +
> +HEX_CPU_INIT(v5, HEX_VER_V5)
> +HEX_CPU_INIT(v55, HEX_VER_V55)
> +HEX_CPU_INIT(v60, HEX_VER_V60)
> +HEX_CPU_INIT(v61, HEX_VER_V61)
> +HEX_CPU_INIT(v62, HEX_VER_V62)
> +HEX_CPU_INIT(v65, HEX_VER_V65)
> +HEX_CPU_INIT(v66, HEX_VER_V66)
> +HEX_CPU_INIT(v67, HEX_VER_V67)
> +HEX_CPU_INIT(v68, HEX_VER_V68)
> +HEX_CPU_INIT(v69, HEX_VER_V69)
> +HEX_CPU_INIT(v71, HEX_VER_V71)
> +HEX_CPU_INIT(v73, HEX_VER_V73)
>  
>  static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>  {
> @@ -395,6 +405,12 @@ static const TypeInfo hexagon_cpu_type_infos[] = {
>          .class_size = sizeof(HexagonCPUClass),
>          .class_init = hexagon_cpu_class_init,
>      },
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               hexagon_v5_cpu_init),
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              hexagon_v55_cpu_init),
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V60,              hexagon_v60_cpu_init),
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V61,              hexagon_v61_cpu_init),
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V62,              hexagon_v62_cpu_init),
> +    DEFINE_CPU(TYPE_HEXAGON_CPU_V65,              hexagon_v65_cpu_init),
>      DEFINE_CPU(TYPE_HEXAGON_CPU_V66,              hexagon_v66_cpu_init),
>      DEFINE_CPU(TYPE_HEXAGON_CPU_V67,              hexagon_v67_cpu_init),
>      DEFINE_CPU(TYPE_HEXAGON_CPU_V68,              hexagon_v68_cpu_init),
> -- 
> 2.43.0
> 

Hi,

IMO adding a HexagonCPUDef struct and using TypeInfo::class_data,
similar to RISCV/SPARC, is a neater approach and easier to extend
if you plan to add more model-specific configuration options at
some point.  So something like

  /* cpu.h */

  struct HexagonCPUDef {
      HexagonVersion version;
  };

  struct HexagonCPUClass {
      ...
      const HexagonCPUDef *def;
  };

  /* cpu.c */

  static void hexagon_cpu_class_base_init(ObjectClass *c, const void *data)
  {
      HexagonCPUClass *mcc = HEXAGON_CPU_CLASS(c);
      /* Make sure all CPU models define a HexagonCPUDef */
      g_assert(!object_class_is_abstract(c) && data != NULL);
      if (data) {
  	  mcc->def = data;
      }
  }
  
  #define DEFINE_CPU(type_name, version)         \
      {                                          \
          .name = type_name,                     \
          .parent = TYPE_HEXAGON_CPU,            \
  	  .class_data = &(const HexagonCPUDef) { \
  	      .version = version,                \
  	  },                                     \
      }
  
  static const TypeInfo hexagon_cpu_type_infos[] = {
      {
          .name = TYPE_HEXAGON_CPU,
          .parent = TYPE_CPU,
          .instance_size = sizeof(HexagonCPU),
          .instance_align = __alignof(HexagonCPU),
          .instance_init = hexagon_cpu_init,
          .abstract = true,
          .class_size = sizeof(HexagonCPUClass),
          .class_init = hexagon_cpu_class_init,
  	  .class_base_init = hexagon_cpu_class_base_init,
      },
      DEFINE_CPU(TYPE_HEXAGON_CPU_V5,               HEX_VER_V5),
      DEFINE_CPU(TYPE_HEXAGON_CPU_V55,              HEX_VER_V55),
      ...
  };

and this way you don't need the HEX_CPU_INIT() macros.

-- 
Anton Johansson
rev.ng Labs Srl.

