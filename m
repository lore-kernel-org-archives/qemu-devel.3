Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F025CED25F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 03:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy0t9-0006fM-Sn; Mon, 07 Oct 2024 23:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sy0t8-0006f4-1t
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:27:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_bcain@quicinc.com>)
 id 1sy0t3-0003XV-BJ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 23:27:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497JlHGs006900;
 Tue, 8 Oct 2024 03:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/b8OXJt3EKz9/l+hf6/2C2Dl
 B9WC1Z4LuLRrFqCwaRo=; b=EZ+t6XEvLQRI07qgak3upizSJ93OEUXtMXXC+Ybs
 5s4Iv3q5xtET2u1u/V1VEVCri9LyU6kqN7aOM9SXRi682CZb2lVjYIjzA7zWRpku
 aFv0QrwnBqUqFA8/qXZ11gHJ+7jum2ROaHt6CXwabIpwrZkcZlrBzrpQqMz4i8HX
 mYR2EwJjSsD5AZNzGwx4eFW6VYP6CS4HuSc41aiLj+7okLSFZyqUDXBBjorIsTmI
 UACVfS+cIizPwWqtxOXOIsM7TqMKdY96533rGVQyRp2VkwHorPyp5KEGr7gKCzQo
 YTccK9i9Bf18sO8UuqMN5u9IgJA0b6kYDVMyxEjPCia1tg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424cy7aee0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Oct 2024 03:27:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4983RgbJ013787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 8 Oct 2024 03:27:42 GMT
Received: from [10.111.163.136] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Oct 2024
 20:27:40 -0700
Content-Type: multipart/alternative;
 boundary="------------UuOUtz6QGYS9S8Sur57V5f34"
Message-ID: <ae024a03-17df-4636-87bb-3d0313f03596@quicinc.com>
Date: Mon, 7 Oct 2024 22:27:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, <junjie.mao@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
 <cf288711-259e-4b06-96aa-6c681b263bee@quicinc.com>
 <CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <quic_bcain@quicinc.com>
In-Reply-To: <CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: vPvRUPjWRYR_iMTdP7SrZ969saRteliF
X-Proofpoint-GUID: vPvRUPjWRYR_iMTdP7SrZ969saRteliF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080021
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_bcain@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--------------UuOUtz6QGYS9S8Sur57V5f34
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 10/7/2024 2:15 PM, Paolo Bonzini wrote:
>
>
> Il lun 7 ott 2024, 19:56 Brian Cain <quic_bcain@quicinc.com> ha scritto:
>
>
>     On 10/7/2024 6:03 AM, Paolo Bonzini wrote:
>     > The following changes since commit
>     b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>     >
>     >    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu
>     into staging (2024-10-04 19:28:37 +0100)
>     >
>     > are available in the Git repository at:
>     >
>     > https://gitlab.com/bonzini/qemu.git tags/for-upstream
>     >
>     > for you to fetch changes up to
>     dec4b629fc17fedcd2172066071f99ec8dcc8d8d:
>     >
>     >    meson: ensure -mcx16 is passed when detecting ATOMIC128
>     (2024-10-07 13:01:06 +0200)
>     >
>     > ----------------------------------------------------------------
>     > * first commit for Rust support
>
>     Aside: Paolo, thanks for your work here!
>
>
> Thanks to Manos, I am just the shepherd. :)
>
>     So far I think the focus for Rust support has been on device
>     models.  But is there any interest in
>     being able to write TCG plugins in Rust
>
>
> Is there a good degree of ABI compatibility across QEMU versions? If 
> so, plugins are external shared libraries and therefore they could be 
> built (with Cargo) independent of any QEMU code.
>
> I am not involved in plugins work, so I am not the best person to answer!


After watching the recording of Alex's KVM Forum presentation on the 
plugins, he's answered my question -- he described the rust bindings 
specifically as "...might require us to be a little bit more formal 
about specifying a proper API..." -- so maybe not a top priority for now.


>
> Paolo
>
>
>
>     This project https://github.com/novafacing/qemu-rs seems to
>     explore this
>     space - maybe it would be good to incorporate something like this
>     inside
>     of QEMU?
>
>     > * fix detection of ATOMIC128 on x86_64
>     >
>     > ----------------------------------------------------------------
>     > Manos Pitsidianakis (7):
>     >        build-sys: Add rust feature option
>     >        rust: add bindgen step as a meson dependency
>     >        .gitattributes: add Rust diff and merge attributes
>     >        meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
>     >        rust: add crate to expose bindings and interfaces
>     >        rust: add utility procedural macro crate
>     >        rust: add PL011 device model
>     >
>     > Paolo Bonzini (4):
>     >        Require meson version 1.5.0
>     >        configure, meson: detect Rust toolchain
>     >        meson: define qemu_isa_flags
>     >        meson: ensure -mcx16 is passed when detecting ATOMIC128
>     >
>     > Pierrick Bouvier (1):
>     >        meson: fix machine option for x86_version
>     >
>     >   MAINTAINERS |  21 +
>     >   configure | 170 +++++-
>     >   meson.build | 158 +++++-
>     >   rust/wrapper.h  |  47 ++
>     >   .gitattributes  |   3 +
>     >   Kconfig |   1 +
>     >   Kconfig.host  |   3 +
>     >   hw/arm/Kconfig  |  30 +-
>     >   meson_options.txt |   3 +
>     >   python/scripts/vendor.py  |   4 +-
>     >   python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 964928 -> 0
>     bytes
>     >   python/wheels/meson-1.5.0-py3-none-any.whl  | Bin 0 -> 959846
>     bytes
>     >   pythondeps.toml |   2 +-
>     >   rust/.gitignore |   3 +
>     >   rust/Kconfig  |   1 +
>     >   rust/hw/Kconfig |   2 +
>     >   rust/hw/char/Kconfig  |   3 +
>     >   rust/hw/char/meson.build  |   1 +
>     >   rust/hw/char/pl011/.gitignore |   2 +
>     >   rust/hw/char/pl011/Cargo.lock | 134 +++++
>     >   rust/hw/char/pl011/Cargo.toml |  26 +
>     >   rust/hw/char/pl011/README.md  |  31 ++
>     >   rust/hw/char/pl011/meson.build  |  26 +
>     >   rust/hw/char/pl011/src/device.rs <http://device.rs>           
>            | 599 +++++++++++++++++++++
>     >   rust/hw/char/pl011/src/device_class.rs
>     <http://device_class.rs>  |  70 +++
>     >   rust/hw/char/pl011/src/lib.rs <http://lib.rs>                 
>         | 586 ++++++++++++++++++++
>     >   rust/hw/char/pl011/src/memory_ops.rs <http://memory_ops.rs>  
>                |  59 ++
>     >   rust/hw/meson.build |   1 +
>     >   rust/meson.build  |   4 +
>     >   rust/qemu-api-macros/Cargo.lock |  47 ++
>     >   rust/qemu-api-macros/Cargo.toml |  25 +
>     >   rust/qemu-api-macros/README.md  |   1 +
>     >   rust/qemu-api-macros/meson.build  |  25 +
>     >   rust/qemu-api-macros/src/lib.rs <http://lib.rs>               
>         | 43 ++
>     >   rust/qemu-api/.gitignore  |   2 +
>     >   rust/qemu-api/Cargo.lock  |   7 +
>     >   rust/qemu-api/Cargo.toml  |  26 +
>     >   rust/qemu-api/README.md |  17 +
>     >   rust/qemu-api/build.rs <http://build.rs>        |  14 +
>     >   rust/qemu-api/meson.build |  24 +
>     >   rust/qemu-api/src/definitions.rs <http://definitions.rs>    | 
>     97 ++++
>     >   rust/qemu-api/src/device_class.rs <http://device_class.rs>    
>     | 128 +++++
>     >   rust/qemu-api/src/lib.rs <http://lib.rs>    | 166 ++++++
>     >   rust/qemu-api/src/tests.rs <http://tests.rs>    |  49 ++
>     >   rust/rustfmt.toml |   7 +
>     >   scripts/archive-source.sh |   6 +-
>     >   scripts/make-release  |   5 +-
>     >   scripts/meson-buildoptions.sh |   3 +
>     >   scripts/rust/rust_root_crate.sh |  13 +
>     >   scripts/rust/rustc_args.py  |  84 +++
>     >   subprojects/.gitignore  |  11 +
>     >   subprojects/arbitrary-int-1-rs.wrap |   7 +
>     >   subprojects/bilge-0.2-rs.wrap |   7 +
>     >   subprojects/bilge-impl-0.2-rs.wrap  |   7 +
>     >   subprojects/either-1-rs.wrap  |   7 +
>     >   subprojects/itertools-0.11-rs.wrap  |   7 +
>     >   .../packagefiles/arbitrary-int-1-rs/meson.build |  19 +
>     >   subprojects/packagefiles/bilge-0.2-rs/meson.build |  29 +
>     >   .../packagefiles/bilge-impl-0.2-rs/meson.build  |  45 ++
>     >   subprojects/packagefiles/either-1-rs/meson.build  |  24 +
>     >   .../packagefiles/itertools-0.11-rs/meson.build  |  30 ++
>     >   .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
>     >   .../proc-macro-error-attr-1-rs/meson.build  |  32 ++
>     >   .../packagefiles/proc-macro2-1-rs/meson.build |  31 ++
>     >   subprojects/packagefiles/quote-1-rs/meson.build |  29 +
>     >   subprojects/packagefiles/syn-2-rs/meson.build |  40 ++
>     >   .../packagefiles/unicode-ident-1-rs/meson.build |  20 +
>     >   subprojects/proc-macro-error-1-rs.wrap  |   7 +
>     >   subprojects/proc-macro-error-attr-1-rs.wrap |   7 +
>     >   subprojects/proc-macro2-1-rs.wrap |   7 +
>     >   subprojects/quote-1-rs.wrap |   7 +
>     >   subprojects/syn-2-rs.wrap |   7 +
>     >   subprojects/unicode-ident-1-rs.wrap |   7 +
>     >   subprojects/unicode-ident-1-rs/meson.build  |  20 +
>     >   tests/lcitool/mappings.yml  |   2 +-
>     >   75 files changed, 3194 insertions(+), 34 deletions(-)
>     >   create mode 100644 rust/wrapper.h
>     >   delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
>     >   create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
>     >   create mode 100644 rust/.gitignore
>     >   create mode 100644 rust/Kconfig
>     >   create mode 100644 rust/hw/Kconfig
>     >   create mode 100644 rust/hw/char/Kconfig
>     >   create mode 100644 rust/hw/char/meson.build
>     >   create mode 100644 rust/hw/char/pl011/.gitignore
>     >   create mode 100644 rust/hw/char/pl011/Cargo.lock
>     >   create mode 100644 rust/hw/char/pl011/Cargo.toml
>     >   create mode 100644 rust/hw/char/pl011/README.md
>     >   create mode 100644 rust/hw/char/pl011/meson.build
>     >   create mode 100644 rust/hw/char/pl011/src/device.rs
>     <http://device.rs>
>     >   create mode 100644 rust/hw/char/pl011/src/device_class.rs
>     <http://device_class.rs>
>     >   create mode 100644 rust/hw/char/pl011/src/lib.rs <http://lib.rs>
>     >   create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
>     <http://memory_ops.rs>
>     >   create mode 100644 rust/hw/meson.build
>     >   create mode 100644 rust/meson.build
>     >   create mode 100644 rust/qemu-api-macros/Cargo.lock
>     >   create mode 100644 rust/qemu-api-macros/Cargo.toml
>     >   create mode 100644 rust/qemu-api-macros/README.md
>     >   create mode 100644 rust/qemu-api-macros/meson.build
>     >   create mode 100644 rust/qemu-api-macros/src/lib.rs <http://lib.rs>
>     >   create mode 100644 rust/qemu-api/.gitignore
>     >   create mode 100644 rust/qemu-api/Cargo.lock
>     >   create mode 100644 rust/qemu-api/Cargo.toml
>     >   create mode 100644 rust/qemu-api/README.md
>     >   create mode 100644 rust/qemu-api/build.rs <http://build.rs>
>     >   create mode 100644 rust/qemu-api/meson.build
>     >   create mode 100644 rust/qemu-api/src/definitions.rs
>     <http://definitions.rs>
>     >   create mode 100644 rust/qemu-api/src/device_class.rs
>     <http://device_class.rs>
>     >   create mode 100644 rust/qemu-api/src/lib.rs <http://lib.rs>
>     >   create mode 100644 rust/qemu-api/src/tests.rs <http://tests.rs>
>     >   create mode 100644 rust/rustfmt.toml
>     >   create mode 100755 scripts/rust/rust_root_crate.sh
>     >   create mode 100644 scripts/rust/rustc_args.py
>     >   create mode 100644 subprojects/arbitrary-int-1-rs.wrap
>     >   create mode 100644 subprojects/bilge-0.2-rs.wrap
>     >   create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
>     >   create mode 100644 subprojects/either-1-rs.wrap
>     >   create mode 100644 subprojects/itertools-0.11-rs.wrap
>     >   create mode 100644
>     subprojects/packagefiles/arbitrary-int-1-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/bilge-0.2-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/either-1-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/itertools-0.11-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/proc-macro-error-1-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/proc-macro2-1-rs/meson.build
>     >   create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
>     >   create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
>     >   create mode 100644
>     subprojects/packagefiles/unicode-ident-1-rs/meson.build
>     >   create mode 100644 subprojects/proc-macro-error-1-rs.wrap
>     >   create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
>     >   create mode 100644 subprojects/proc-macro2-1-rs.wrap
>     >   create mode 100644 subprojects/quote-1-rs.wrap
>     >   create mode 100644 subprojects/syn-2-rs.wrap
>     >   create mode 100644 subprojects/unicode-ident-1-rs.wrap
>     >   create mode 100644 subprojects/unicode-ident-1-rs/meson.build
>
--------------UuOUtz6QGYS9S8Sur57V5f34
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/7/2024 2:15 PM, Paolo Bonzini
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <div dir="auto">
        <div><br>
          <br>
          <div class="gmail_quote">
            <div dir="ltr" class="gmail_attr">Il lun 7 ott 2024, 19:56
              Brian Cain &lt;<a href="mailto:quic_bcain@quicinc.com"
                moz-do-not-send="true" class="moz-txt-link-freetext">quic_bcain@quicinc.com</a>&gt;
              ha scritto:<br>
            </div>
            <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
              On 10/7/2024 6:03 AM, Paolo Bonzini wrote:<br>
              &gt; The following changes since commit
              b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:<br>
              &gt;<br>
              &gt;    Merge tag 'for-upstream' of <a
                href="https://gitlab.com/bonzini/qemu"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.com/bonzini/qemu</a>
              into staging (2024-10-04 19:28:37 +0100)<br>
              &gt;<br>
              &gt; are available in the Git repository at:<br>
              &gt;<br>
              &gt;    <a href="https://gitlab.com/bonzini/qemu.git"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">https://gitlab.com/bonzini/qemu.git</a>
              tags/for-upstream<br>
              &gt;<br>
              &gt; for you to fetch changes up to
              dec4b629fc17fedcd2172066071f99ec8dcc8d8d:<br>
              &gt;<br>
              &gt;    meson: ensure -mcx16 is passed when detecting
              ATOMIC128 (2024-10-07 13:01:06 +0200)<br>
              &gt;<br>
              &gt;
              ----------------------------------------------------------------<br>
              &gt; * first commit for Rust support<br>
              <br>
              Aside: Paolo, thanks for your work here!</blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Thanks to Manos, I am just the shepherd. :)</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So
              far I think the focus for Rust support has been on device
              models.  But is there any interest in <br>
              being able to write TCG plugins in Rust<br>
            </blockquote>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Is there a good degree of ABI compatibility
          across QEMU versions? If so, plugins are external shared
          libraries and therefore they could be built (with Cargo)
          independent of any QEMU code.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">I am not involved in plugins work, so I am not
          the best person to answer!</div>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>After watching the recording of Alex's KVM Forum presentation on
      the plugins, he's answered my question -- he described the rust
      bindings specifically as "...might require us to be a little bit
      more formal about specifying a proper API..." -- so maybe not a
      top priority for now.</p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CABgObfa9Zsn47PEoNfDBOg3sbkzXa-Cz4QLocCH9E=3yz8T4Xg@mail.gmail.com">
      <div dir="auto">
        <div dir="auto"><br>
        </div>
        <div dir="auto">Paolo </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_quote">
            <blockquote class="gmail_quote"
style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              <br>
              This project <a
                href="https://github.com/novafacing/qemu-rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">https://github.com/novafacing/qemu-rs</a>
              seems to explore this <br>
              space - maybe it would be good to incorporate something
              like this inside <br>
              of QEMU?<br>
              <br>
              &gt; * fix detection of ATOMIC128 on x86_64<br>
              &gt;<br>
              &gt;
              ----------------------------------------------------------------<br>
              &gt; Manos Pitsidianakis (7):<br>
              &gt;        build-sys: Add rust feature option<br>
              &gt;        rust: add bindgen step as a meson dependency<br>
              &gt;        .gitattributes: add Rust diff and merge
              attributes<br>
              &gt;        meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC
              flag<br>
              &gt;        rust: add crate to expose bindings and
              interfaces<br>
              &gt;        rust: add utility procedural macro crate<br>
              &gt;        rust: add PL011 device model<br>
              &gt;<br>
              &gt; Paolo Bonzini (4):<br>
              &gt;        Require meson version 1.5.0<br>
              &gt;        configure, meson: detect Rust toolchain<br>
              &gt;        meson: define qemu_isa_flags<br>
              &gt;        meson: ensure -mcx16 is passed when detecting
              ATOMIC128<br>
              &gt;<br>
              &gt; Pierrick Bouvier (1):<br>
              &gt;        meson: fix machine option for x86_version<br>
              &gt;<br>
              &gt;   MAINTAINERS                                       
              |  21 +<br>
              &gt;   configure                                         
              | 170 +++++-<br>
              &gt;   meson.build                                       
              | 158 +++++-<br>
              &gt;   rust/wrapper.h                                   
               |  47 ++<br>
              &gt;   .gitattributes                                   
               |   3 +<br>
              &gt;   Kconfig                                           
              |   1 +<br>
              &gt;   Kconfig.host                                     
               |   3 +<br>
              &gt;   hw/arm/Kconfig                                   
               |  30 +-<br>
              &gt;   meson_options.txt                                 
              |   3 +<br>
              &gt;   python/scripts/vendor.py                         
               |   4 +-<br>
              &gt;   python/wheels/meson-1.2.3-py3-none-any.whl       
               | Bin 964928 -&gt; 0 bytes<br>
              &gt;   python/wheels/meson-1.5.0-py3-none-any.whl       
               | Bin 0 -&gt; 959846 bytes<br>
              &gt;   pythondeps.toml                                   
              |   2 +-<br>
              &gt;   rust/.gitignore                                   
              |   3 +<br>
              &gt;   rust/Kconfig                                     
               |   1 +<br>
              &gt;   rust/hw/Kconfig                                   
              |   2 +<br>
              &gt;   rust/hw/char/Kconfig                             
               |   3 +<br>
              &gt;   rust/hw/char/meson.build                         
               |   1 +<br>
              &gt;   rust/hw/char/pl011/.gitignore                     
              |   2 +<br>
              &gt;   rust/hw/char/pl011/Cargo.lock                     
              | 134 +++++<br>
              &gt;   rust/hw/char/pl011/Cargo.toml                     
              |  26 +<br>
              &gt;   rust/hw/char/pl011/README.md                     
               |  31 ++<br>
              &gt;   rust/hw/char/pl011/meson.build                   
               |  26 +<br>
              &gt;   rust/hw/char/pl011/src/<a href="http://device.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">device.rs</a>                   |
              599 +++++++++++++++++++++<br>
              &gt;   rust/hw/char/pl011/src/<a
                href="http://device_class.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">device_class.rs</a>           
               |  70 +++<br>
              &gt;   rust/hw/char/pl011/src/<a href="http://lib.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">lib.rs</a>                      |
              586 ++++++++++++++++++++<br>
              &gt;   rust/hw/char/pl011/src/<a
                href="http://memory_ops.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">memory_ops.rs</a> 
                           |  59 ++<br>
              &gt;   rust/hw/meson.build                               
              |   1 +<br>
              &gt;   rust/meson.build                                 
               |   4 +<br>
              &gt;   rust/qemu-api-macros/Cargo.lock                   
              |  47 ++<br>
              &gt;   rust/qemu-api-macros/Cargo.toml                   
              |  25 +<br>
              &gt;   rust/qemu-api-macros/README.md                   
               |   1 +<br>
              &gt;   rust/qemu-api-macros/meson.build                 
               |  25 +<br>
              &gt;   rust/qemu-api-macros/src/<a href="http://lib.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">lib.rs</a>                    | 
              43 ++<br>
              &gt;   rust/qemu-api/.gitignore                         
               |   2 +<br>
              &gt;   rust/qemu-api/Cargo.lock                         
               |   7 +<br>
              &gt;   rust/qemu-api/Cargo.toml                         
               |  26 +<br>
              &gt;   rust/qemu-api/README.md                           
              |  17 +<br>
              &gt;   rust/qemu-api/<a href="http://build.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">build.rs</a>                     
                     |  14 +<br>
              &gt;   rust/qemu-api/meson.build                         
              |  24 +<br>
              &gt;   rust/qemu-api/src/<a href="http://definitions.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">definitions.rs</a>               
                 |  97 ++++<br>
              &gt;   rust/qemu-api/src/<a href="http://device_class.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">device_class.rs</a>             
                  | 128 +++++<br>
              &gt;   rust/qemu-api/src/<a href="http://lib.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">lib.rs</a>                       
                 | 166 ++++++<br>
              &gt;   rust/qemu-api/src/<a href="http://tests.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">tests.rs</a>                     
                 |  49 ++<br>
              &gt;   rust/rustfmt.toml                                 
              |   7 +<br>
              &gt;   scripts/archive-source.sh                         
              |   6 +-<br>
              &gt;   scripts/make-release                             
               |   5 +-<br>
              &gt;   scripts/meson-buildoptions.sh                     
              |   3 +<br>
              &gt;   scripts/rust/rust_root_crate.sh                   
              |  13 +<br>
              &gt;   scripts/rust/rustc_args.py                       
               |  84 +++<br>
              &gt;   subprojects/.gitignore                           
               |  11 +<br>
              &gt;   subprojects/arbitrary-int-1-rs.wrap               
              |   7 +<br>
              &gt;   subprojects/bilge-0.2-rs.wrap                     
              |   7 +<br>
              &gt;   subprojects/bilge-impl-0.2-rs.wrap               
               |   7 +<br>
              &gt;   subprojects/either-1-rs.wrap                     
               |   7 +<br>
              &gt;   subprojects/itertools-0.11-rs.wrap               
               |   7 +<br>
              &gt;   .../packagefiles/arbitrary-int-1-rs/meson.build   
              |  19 +<br>
              &gt;   subprojects/packagefiles/bilge-0.2-rs/meson.build 
              |  29 +<br>
              &gt;   .../packagefiles/bilge-impl-0.2-rs/meson.build   
               |  45 ++<br>
              &gt;   subprojects/packagefiles/either-1-rs/meson.build 
               |  24 +<br>
              &gt;   .../packagefiles/itertools-0.11-rs/meson.build   
               |  30 ++<br>
              &gt;   .../packagefiles/proc-macro-error-1-rs/meson.build
              |  40 ++<br>
              &gt;   .../proc-macro-error-attr-1-rs/meson.build       
               |  32 ++<br>
              &gt;   .../packagefiles/proc-macro2-1-rs/meson.build     
              |  31 ++<br>
              &gt;   subprojects/packagefiles/quote-1-rs/meson.build   
              |  29 +<br>
              &gt;   subprojects/packagefiles/syn-2-rs/meson.build     
              |  40 ++<br>
              &gt;   .../packagefiles/unicode-ident-1-rs/meson.build   
              |  20 +<br>
              &gt;   subprojects/proc-macro-error-1-rs.wrap           
               |   7 +<br>
              &gt;   subprojects/proc-macro-error-attr-1-rs.wrap       
              |   7 +<br>
              &gt;   subprojects/proc-macro2-1-rs.wrap                 
              |   7 +<br>
              &gt;   subprojects/quote-1-rs.wrap                       
              |   7 +<br>
              &gt;   subprojects/syn-2-rs.wrap                         
              |   7 +<br>
              &gt;   subprojects/unicode-ident-1-rs.wrap               
              |   7 +<br>
              &gt;   subprojects/unicode-ident-1-rs/meson.build       
               |  20 +<br>
              &gt;   tests/lcitool/mappings.yml                       
               |   2 +-<br>
              &gt;   75 files changed, 3194 insertions(+), 34
              deletions(-)<br>
              &gt;   create mode 100644 rust/wrapper.h<br>
              &gt;   delete mode 100644
              python/wheels/meson-1.2.3-py3-none-any.whl<br>
              &gt;   create mode 100644
              python/wheels/meson-1.5.0-py3-none-any.whl<br>
              &gt;   create mode 100644 rust/.gitignore<br>
              &gt;   create mode 100644 rust/Kconfig<br>
              &gt;   create mode 100644 rust/hw/Kconfig<br>
              &gt;   create mode 100644 rust/hw/char/Kconfig<br>
              &gt;   create mode 100644 rust/hw/char/meson.build<br>
              &gt;   create mode 100644 rust/hw/char/pl011/.gitignore<br>
              &gt;   create mode 100644 rust/hw/char/pl011/Cargo.lock<br>
              &gt;   create mode 100644 rust/hw/char/pl011/Cargo.toml<br>
              &gt;   create mode 100644 rust/hw/char/pl011/README.md<br>
              &gt;   create mode 100644 rust/hw/char/pl011/meson.build<br>
              &gt;   create mode 100644 rust/hw/char/pl011/src/<a
                href="http://device.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">device.rs</a><br>
              &gt;   create mode 100644 rust/hw/char/pl011/src/<a
                href="http://device_class.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">device_class.rs</a><br>
              &gt;   create mode 100644 rust/hw/char/pl011/src/<a
                href="http://lib.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">lib.rs</a><br>
              &gt;   create mode 100644 rust/hw/char/pl011/src/<a
                href="http://memory_ops.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">memory_ops.rs</a><br>
              &gt;   create mode 100644 rust/hw/meson.build<br>
              &gt;   create mode 100644 rust/meson.build<br>
              &gt;   create mode 100644 rust/qemu-api-macros/Cargo.lock<br>
              &gt;   create mode 100644 rust/qemu-api-macros/Cargo.toml<br>
              &gt;   create mode 100644 rust/qemu-api-macros/README.md<br>
              &gt;   create mode 100644 rust/qemu-api-macros/meson.build<br>
              &gt;   create mode 100644 rust/qemu-api-macros/src/<a
                href="http://lib.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">lib.rs</a><br>
              &gt;   create mode 100644 rust/qemu-api/.gitignore<br>
              &gt;   create mode 100644 rust/qemu-api/Cargo.lock<br>
              &gt;   create mode 100644 rust/qemu-api/Cargo.toml<br>
              &gt;   create mode 100644 rust/qemu-api/README.md<br>
              &gt;   create mode 100644 rust/qemu-api/<a
                href="http://build.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">build.rs</a><br>
              &gt;   create mode 100644 rust/qemu-api/meson.build<br>
              &gt;   create mode 100644 rust/qemu-api/src/<a
                href="http://definitions.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">definitions.rs</a><br>
              &gt;   create mode 100644 rust/qemu-api/src/<a
                href="http://device_class.rs"
                rel="noreferrer noreferrer" target="_blank"
                moz-do-not-send="true">device_class.rs</a><br>
              &gt;   create mode 100644 rust/qemu-api/src/<a
                href="http://lib.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">lib.rs</a><br>
              &gt;   create mode 100644 rust/qemu-api/src/<a
                href="http://tests.rs" rel="noreferrer noreferrer"
                target="_blank" moz-do-not-send="true">tests.rs</a><br>
              &gt;   create mode 100644 rust/rustfmt.toml<br>
              &gt;   create mode 100755 scripts/rust/rust_root_crate.sh<br>
              &gt;   create mode 100644 scripts/rust/rustc_args.py<br>
              &gt;   create mode 100644
              subprojects/arbitrary-int-1-rs.wrap<br>
              &gt;   create mode 100644 subprojects/bilge-0.2-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/bilge-impl-0.2-rs.wrap<br>
              &gt;   create mode 100644 subprojects/either-1-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/itertools-0.11-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/packagefiles/arbitrary-int-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/bilge-0.2-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/bilge-impl-0.2-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/either-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/itertools-0.11-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/proc-macro-error-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/proc-macro2-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/quote-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/syn-2-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/packagefiles/unicode-ident-1-rs/meson.build<br>
              &gt;   create mode 100644
              subprojects/proc-macro-error-1-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/proc-macro-error-attr-1-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/proc-macro2-1-rs.wrap<br>
              &gt;   create mode 100644 subprojects/quote-1-rs.wrap<br>
              &gt;   create mode 100644 subprojects/syn-2-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/unicode-ident-1-rs.wrap<br>
              &gt;   create mode 100644
              subprojects/unicode-ident-1-rs/meson.build<br>
              <br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------UuOUtz6QGYS9S8Sur57V5f34--

