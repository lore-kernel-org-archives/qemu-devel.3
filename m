Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E251C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 08:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWAmz-0005an-AV; Tue, 23 Jul 2024 04:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWAmw-0005Qi-V0
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:26 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sWAmr-0000Z5-5J
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 04:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721722941; x=1753258941;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=wx+jG3q6/rgh/1H0VrpLBLF245++3cR5bkeBzHo+XCA=;
 b=NWNR2S5EhqcEueKH4Dly4Lt+SBGZn0XBVIha9G+m37wXLhEhz50reD/v
 HyqY8TUpBs3vyNMxK5uQknVkY2WKB/DTkEQ9k72MJqkTSJdJus1frRSbV
 Xxq7LpGjW62tLuO9gn6moRfw3yhr/iXicDFfroaFBkw9VWwbzVUuaxnl5
 rXwDGkbaAa6PUwUej0Kxe7Un/+YweX7CzKGQ2adpJcnFhNME9n8VxX0ni
 NqZGB8W4NIfEMkWM+GP02EvOkPN6tF2F8IWOIEchX1ruRUTp+k3cr4ddS
 UnFBXH6VR8/UomEXiHxE63dAMpjBcz0zC8Thy267QB+v8ch00xcPADJ6E A==;
X-CSE-ConnectionGUID: VxQXUTT+TOicO/qmPPAf+A==
X-CSE-MsgGUID: fad37fUxTUaLLvs31CET9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19458639"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="19458639"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 01:22:19 -0700
X-CSE-ConnectionGUID: rRqc6N4VSuqbXKqojIb9DA==
X-CSE-MsgGUID: IG4z0528RpK25RzCXTfIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="56997033"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 23 Jul 2024 01:22:15 -0700
Date: Tue, 23 Jul 2024 16:37:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH v5 8/8] rust/pl011: vendor dependencies
Message-ID: <Zp9r59I4Uy655+4L@intel.com>
References: <rust-pl011-rfc-v5.git.manos.pitsidianakis@linaro.org>
 <43d9c3f65224f28f78f28d15e67b999d84a3b66f.1721648163.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43d9c3f65224f28f78f28d15e67b999d84a3b66f.1721648163.git.manos.pitsidianakis@linaro.org>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Manos,

(This patch contains too many codes so that mail list rejects to display
it at https://lore.kernel.org/qemu-devel)

Please correct me if I'm wrong...

Is the reason for not using git submodules here because v5 abandoned
compilation through Cargo, so it¡¯s necessary to add meson.build to the
code repository of each dependency, and consequently, all code must be
loaded into QEMU?

It looks like will be difficult to synchronize the dependency changes
in the future.

Best Regards,
Zhao

On Mon, Jul 22, 2024 at 02:43:38PM +0300, Manos Pitsidianakis wrote:
> Date: Mon, 22 Jul 2024 14:43:38 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [RFC PATCH v5 8/8] rust/pl011: vendor dependencies
> X-Mailer: git-send-email 2.44.0
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/hw/char/pl011/vendor/either/README.rst   |  185 +
>  .../vendor/arbitrary-int/.cargo-checksum.json |    1 +
>  .../pl011/vendor/arbitrary-int/CHANGELOG.md   |   47 +
>  .../pl011/vendor/arbitrary-int/Cargo.toml     |   54 +
>  .../pl011/vendor/arbitrary-int/LICENSE.txt    |   21 +
>  .../char/pl011/vendor/arbitrary-int/README.md |   72 +
>  .../pl011/vendor/arbitrary-int/meson.build    |   14 +
>  .../pl011/vendor/arbitrary-int/src/lib.rs     | 1489 +++++
>  .../pl011/vendor/arbitrary-int/tests/tests.rs | 1913 ++++++
>  .../vendor/bilge-impl/.cargo-checksum.json    |    1 +
>  .../char/pl011/vendor/bilge-impl/Cargo.toml   |   54 +
>  .../hw/char/pl011/vendor/bilge-impl/README.md |  327 ++
>  .../char/pl011/vendor/bilge-impl/meson.build  |   24 +
>  .../pl011/vendor/bilge-impl/src/bitsize.rs    |  187 +
>  .../vendor/bilge-impl/src/bitsize/split.rs    |  185 +
>  .../vendor/bilge-impl/src/bitsize_internal.rs |  235 +
>  .../src/bitsize_internal/struct_gen.rs        |  402 ++
>  .../pl011/vendor/bilge-impl/src/debug_bits.rs |   55 +
>  .../vendor/bilge-impl/src/default_bits.rs     |   92 +
>  .../pl011/vendor/bilge-impl/src/fmt_bits.rs   |  112 +
>  .../pl011/vendor/bilge-impl/src/from_bits.rs  |  222 +
>  .../char/pl011/vendor/bilge-impl/src/lib.rs   |   79 +
>  .../pl011/vendor/bilge-impl/src/shared.rs     |  196 +
>  .../src/shared/discriminant_assigner.rs       |   56 +
>  .../vendor/bilge-impl/src/shared/fallback.rs  |   92 +
>  .../vendor/bilge-impl/src/shared/util.rs      |   91 +
>  .../vendor/bilge-impl/src/try_from_bits.rs    |  143 +
>  .../pl011/vendor/bilge/.cargo-checksum.json   |    1 +
>  rust/hw/char/pl011/vendor/bilge/Cargo.toml    |   69 +
>  .../hw/char/pl011/vendor/bilge/LICENSE-APACHE |  176 +
>  rust/hw/char/pl011/vendor/bilge/LICENSE-MIT   |   17 +
>  rust/hw/char/pl011/vendor/bilge/README.md     |  327 ++
>  rust/hw/char/pl011/vendor/bilge/meson.build   |   17 +
>  rust/hw/char/pl011/vendor/bilge/src/lib.rs    |   80 +
>  .../pl011/vendor/either/.cargo-checksum.json  |    1 +
>  rust/hw/char/pl011/vendor/either/Cargo.toml   |   54 +
>  .../char/pl011/vendor/either/LICENSE-APACHE   |  201 +
>  rust/hw/char/pl011/vendor/either/LICENSE-MIT  |   25 +
>  .../pl011/vendor/either/README-crates.io.md   |   10 +
>  rust/hw/char/pl011/vendor/either/meson.build  |   16 +
>  .../pl011/vendor/either/src/into_either.rs    |   64 +
>  .../char/pl011/vendor/either/src/iterator.rs  |  315 +
>  rust/hw/char/pl011/vendor/either/src/lib.rs   | 1519 +++++
>  .../pl011/vendor/either/src/serde_untagged.rs |   69 +
>  .../either/src/serde_untagged_optional.rs     |   74 +
>  .../vendor/itertools/.cargo-checksum.json     |    1 +
>  .../char/pl011/vendor/itertools/CHANGELOG.md  |  409 ++
>  .../hw/char/pl011/vendor/itertools/Cargo.lock |  681 +++
>  .../hw/char/pl011/vendor/itertools/Cargo.toml |  101 +
>  .../pl011/vendor/itertools/LICENSE-APACHE     |  201 +
>  .../char/pl011/vendor/itertools/LICENSE-MIT   |   25 +
>  rust/hw/char/pl011/vendor/itertools/README.md |   44 +
>  .../pl011/vendor/itertools/benches/bench1.rs  |  877 +++
>  .../vendor/itertools/benches/combinations.rs  |  125 +
>  .../benches/combinations_with_replacement.rs  |   40 +
>  .../vendor/itertools/benches/extra/mod.rs     |    2 +
>  .../itertools/benches/extra/zipslices.rs      |  188 +
>  .../itertools/benches/fold_specialization.rs  |   73 +
>  .../vendor/itertools/benches/powerset.rs      |   44 +
>  .../vendor/itertools/benches/tree_fold1.rs    |  144 +
>  .../itertools/benches/tuple_combinations.rs   |  113 +
>  .../pl011/vendor/itertools/benches/tuples.rs  |  213 +
>  .../pl011/vendor/itertools/examples/iris.data |  150 +
>  .../pl011/vendor/itertools/examples/iris.rs   |  137 +
>  .../char/pl011/vendor/itertools/meson.build   |   18 +
>  .../vendor/itertools/src/adaptors/coalesce.rs |  235 +
>  .../vendor/itertools/src/adaptors/map.rs      |  124 +
>  .../vendor/itertools/src/adaptors/mod.rs      | 1151 ++++
>  .../itertools/src/adaptors/multi_product.rs   |  230 +
>  .../vendor/itertools/src/combinations.rs      |  128 +
>  .../src/combinations_with_replacement.rs      |  109 +
>  .../pl011/vendor/itertools/src/concat_impl.rs |   23 +
>  .../vendor/itertools/src/cons_tuples_impl.rs  |   64 +
>  .../char/pl011/vendor/itertools/src/diff.rs   |   61 +
>  .../vendor/itertools/src/duplicates_impl.rs   |  216 +
>  .../vendor/itertools/src/either_or_both.rs    |  495 ++
>  .../vendor/itertools/src/exactly_one_err.rs   |  110 +
>  .../pl011/vendor/itertools/src/extrema_set.rs |   48 +
>  .../pl011/vendor/itertools/src/flatten_ok.rs  |  165 +
>  .../char/pl011/vendor/itertools/src/format.rs |  168 +
>  .../char/pl011/vendor/itertools/src/free.rs   |  286 +
>  .../pl011/vendor/itertools/src/group_map.rs   |   32 +
>  .../pl011/vendor/itertools/src/groupbylazy.rs |  579 ++
>  .../vendor/itertools/src/grouping_map.rs      |  535 ++
>  .../pl011/vendor/itertools/src/impl_macros.rs |   29 +
>  .../pl011/vendor/itertools/src/intersperse.rs |  118 +
>  .../pl011/vendor/itertools/src/k_smallest.rs  |   20 +
>  .../pl011/vendor/itertools/src/kmerge_impl.rs |  227 +
>  .../pl011/vendor/itertools/src/lazy_buffer.rs |   63 +
>  .../hw/char/pl011/vendor/itertools/src/lib.rs | 3967 +++++++++++++
>  .../pl011/vendor/itertools/src/merge_join.rs  |  220 +
>  .../char/pl011/vendor/itertools/src/minmax.rs |  115 +
>  .../vendor/itertools/src/multipeek_impl.rs    |  101 +
>  .../pl011/vendor/itertools/src/pad_tail.rs    |   96 +
>  .../pl011/vendor/itertools/src/peek_nth.rs    |  102 +
>  .../itertools/src/peeking_take_while.rs       |  177 +
>  .../vendor/itertools/src/permutations.rs      |  277 +
>  .../pl011/vendor/itertools/src/powerset.rs    |   90 +
>  .../itertools/src/process_results_impl.rs     |   68 +
>  .../vendor/itertools/src/put_back_n_impl.rs   |   61 +
>  .../pl011/vendor/itertools/src/rciter_impl.rs |   99 +
>  .../pl011/vendor/itertools/src/repeatn.rs     |   59 +
>  .../pl011/vendor/itertools/src/size_hint.rs   |  119 +
>  .../pl011/vendor/itertools/src/sources.rs     |  183 +
>  .../itertools/src/take_while_inclusive.rs     |   68 +
>  .../hw/char/pl011/vendor/itertools/src/tee.rs |   78 +
>  .../pl011/vendor/itertools/src/tuple_impl.rs  |  331 ++
>  .../pl011/vendor/itertools/src/unique_impl.rs |  179 +
>  .../pl011/vendor/itertools/src/unziptuple.rs  |   80 +
>  .../vendor/itertools/src/with_position.rs     |   88 +
>  .../pl011/vendor/itertools/src/zip_eq_impl.rs |   60 +
>  .../pl011/vendor/itertools/src/zip_longest.rs |   83 +
>  .../pl011/vendor/itertools/src/ziptuple.rs    |  138 +
>  .../itertools/tests/adaptors_no_collect.rs    |   46 +
>  .../vendor/itertools/tests/flatten_ok.rs      |   76 +
>  .../vendor/itertools/tests/macros_hygiene.rs  |   13 +
>  .../vendor/itertools/tests/merge_join.rs      |  108 +
>  .../itertools/tests/peeking_take_while.rs     |   69 +
>  .../pl011/vendor/itertools/tests/quick.rs     | 1849 ++++++
>  .../vendor/itertools/tests/specializations.rs |  153 +
>  .../pl011/vendor/itertools/tests/test_core.rs |  317 +
>  .../pl011/vendor/itertools/tests/test_std.rs  | 1184 ++++
>  .../pl011/vendor/itertools/tests/tuples.rs    |   86 +
>  .../char/pl011/vendor/itertools/tests/zip.rs  |   77 +
>  rust/hw/char/pl011/vendor/meson.build         |   18 +
>  .../.cargo-checksum.json                      |    1 +
>  .../vendor/proc-macro-error-attr/Cargo.toml   |   33 +
>  .../proc-macro-error-attr/LICENSE-APACHE      |  201 +
>  .../vendor/proc-macro-error-attr/LICENSE-MIT  |   21 +
>  .../vendor/proc-macro-error-attr/build.rs     |    5 +
>  .../vendor/proc-macro-error-attr/meson.build  |   20 +
>  .../vendor/proc-macro-error-attr/src/lib.rs   |  121 +
>  .../vendor/proc-macro-error-attr/src/parse.rs |   89 +
>  .../proc-macro-error-attr/src/settings.rs     |   72 +
>  .../proc-macro-error/.cargo-checksum.json     |    1 +
>  .../vendor/proc-macro-error/CHANGELOG.md      |  162 +
>  .../pl011/vendor/proc-macro-error/Cargo.toml  |   56 +
>  .../vendor/proc-macro-error/LICENSE-APACHE    |  201 +
>  .../pl011/vendor/proc-macro-error/LICENSE-MIT |   21 +
>  .../pl011/vendor/proc-macro-error/README.md   |  258 +
>  .../pl011/vendor/proc-macro-error/build.rs    |   11 +
>  .../pl011/vendor/proc-macro-error/meson.build |   22 +
>  .../vendor/proc-macro-error/src/diagnostic.rs |  349 ++
>  .../vendor/proc-macro-error/src/dummy.rs      |  150 +
>  .../proc-macro-error/src/imp/delegate.rs      |   69 +
>  .../proc-macro-error/src/imp/fallback.rs      |   30 +
>  .../pl011/vendor/proc-macro-error/src/lib.rs  |  560 ++
>  .../vendor/proc-macro-error/src/macros.rs     |  288 +
>  .../vendor/proc-macro-error/src/sealed.rs     |    3 +
>  .../proc-macro-error/tests/macro-errors.rs    |    8 +
>  .../pl011/vendor/proc-macro-error/tests/ok.rs |   10 +
>  .../proc-macro-error/tests/runtime-errors.rs  |   13 +
>  .../vendor/proc-macro-error/tests/ui/abort.rs |   11 +
>  .../proc-macro-error/tests/ui/abort.stderr    |   48 +
>  .../proc-macro-error/tests/ui/append_dummy.rs |   13 +
>  .../tests/ui/append_dummy.stderr              |    5 +
>  .../tests/ui/children_messages.rs             |    6 +
>  .../tests/ui/children_messages.stderr         |   23 +
>  .../vendor/proc-macro-error/tests/ui/dummy.rs |   13 +
>  .../proc-macro-error/tests/ui/dummy.stderr    |    5 +
>  .../vendor/proc-macro-error/tests/ui/emit.rs  |    7 +
>  .../proc-macro-error/tests/ui/emit.stderr     |   48 +
>  .../tests/ui/explicit_span_range.rs           |    6 +
>  .../tests/ui/explicit_span_range.stderr       |    5 +
>  .../proc-macro-error/tests/ui/misuse.rs       |   11 +
>  .../proc-macro-error/tests/ui/misuse.stderr   |   13 +
>  .../tests/ui/multiple_tokens.rs               |    6 +
>  .../tests/ui/multiple_tokens.stderr           |    5 +
>  .../tests/ui/not_proc_macro.rs                |    4 +
>  .../tests/ui/not_proc_macro.stderr            |   10 +
>  .../proc-macro-error/tests/ui/option_ext.rs   |    6 +
>  .../tests/ui/option_ext.stderr                |    7 +
>  .../tests/ui/proc_macro_hack.rs               |   10 +
>  .../tests/ui/proc_macro_hack.stderr           |   26 +
>  .../proc-macro-error/tests/ui/result_ext.rs   |    7 +
>  .../tests/ui/result_ext.stderr                |   11 +
>  .../tests/ui/to_tokens_span.rs                |    6 +
>  .../tests/ui/to_tokens_span.stderr            |   11 +
>  .../tests/ui/unknown_setting.rs               |    4 +
>  .../tests/ui/unknown_setting.stderr           |    5 +
>  .../tests/ui/unrelated_panic.rs               |    6 +
>  .../tests/ui/unrelated_panic.stderr           |    7 +
>  .../vendor/proc-macro2/.cargo-checksum.json   |    1 +
>  .../char/pl011/vendor/proc-macro2/Cargo.toml  |  104 +
>  .../pl011/vendor/proc-macro2/LICENSE-APACHE   |  176 +
>  .../char/pl011/vendor/proc-macro2/LICENSE-MIT |   23 +
>  .../char/pl011/vendor/proc-macro2/README.md   |   94 +
>  .../hw/char/pl011/vendor/proc-macro2/build.rs |  227 +
>  .../pl011/vendor/proc-macro2/build/probe.rs   |   25 +
>  .../char/pl011/vendor/proc-macro2/meson.build |   19 +
>  .../vendor/proc-macro2/rust-toolchain.toml    |    2 +
>  .../pl011/vendor/proc-macro2/src/detection.rs |   75 +
>  .../pl011/vendor/proc-macro2/src/extra.rs     |  151 +
>  .../pl011/vendor/proc-macro2/src/fallback.rs  | 1226 ++++
>  .../char/pl011/vendor/proc-macro2/src/lib.rs  | 1369 +++++
>  .../pl011/vendor/proc-macro2/src/location.rs  |   29 +
>  .../pl011/vendor/proc-macro2/src/marker.rs    |   17 +
>  .../pl011/vendor/proc-macro2/src/parse.rs     |  996 ++++
>  .../pl011/vendor/proc-macro2/src/rcvec.rs     |  145 +
>  .../pl011/vendor/proc-macro2/src/wrapper.rs   |  993 ++++
>  .../vendor/proc-macro2/tests/comments.rs      |  105 +
>  .../vendor/proc-macro2/tests/features.rs      |    8 +
>  .../pl011/vendor/proc-macro2/tests/marker.rs  |  100 +
>  .../pl011/vendor/proc-macro2/tests/test.rs    |  905 +++
>  .../vendor/proc-macro2/tests/test_fmt.rs      |   28 +
>  .../vendor/proc-macro2/tests/test_size.rs     |   73 +
>  .../pl011/vendor/quote/.cargo-checksum.json   |    1 +
>  rust/hw/char/pl011/vendor/quote/Cargo.toml    |   50 +
>  .../hw/char/pl011/vendor/quote/LICENSE-APACHE |  176 +
>  rust/hw/char/pl011/vendor/quote/LICENSE-MIT   |   23 +
>  rust/hw/char/pl011/vendor/quote/README.md     |  272 +
>  rust/hw/char/pl011/vendor/quote/meson.build   |   17 +
>  .../pl011/vendor/quote/rust-toolchain.toml    |    2 +
>  rust/hw/char/pl011/vendor/quote/src/ext.rs    |  110 +
>  rust/hw/char/pl011/vendor/quote/src/format.rs |  168 +
>  .../pl011/vendor/quote/src/ident_fragment.rs  |   88 +
>  rust/hw/char/pl011/vendor/quote/src/lib.rs    | 1464 +++++
>  .../hw/char/pl011/vendor/quote/src/runtime.rs |  530 ++
>  .../hw/char/pl011/vendor/quote/src/spanned.rs |   50 +
>  .../char/pl011/vendor/quote/src/to_tokens.rs  |  209 +
>  .../pl011/vendor/quote/tests/compiletest.rs   |    7 +
>  rust/hw/char/pl011/vendor/quote/tests/test.rs |  549 ++
>  .../ui/does-not-have-iter-interpolated-dup.rs |    9 +
>  ...does-not-have-iter-interpolated-dup.stderr |   11 +
>  .../ui/does-not-have-iter-interpolated.rs     |    9 +
>  .../ui/does-not-have-iter-interpolated.stderr |   11 +
>  .../tests/ui/does-not-have-iter-separated.rs  |    5 +
>  .../ui/does-not-have-iter-separated.stderr    |   10 +
>  .../quote/tests/ui/does-not-have-iter.rs      |    5 +
>  .../quote/tests/ui/does-not-have-iter.stderr  |   10 +
>  .../vendor/quote/tests/ui/not-quotable.rs     |    7 +
>  .../vendor/quote/tests/ui/not-quotable.stderr |   20 +
>  .../vendor/quote/tests/ui/not-repeatable.rs   |    8 +
>  .../quote/tests/ui/not-repeatable.stderr      |   34 +
>  .../vendor/quote/tests/ui/wrong-type-span.rs  |    7 +
>  .../quote/tests/ui/wrong-type-span.stderr     |   10 +
>  .../pl011/vendor/syn/.cargo-checksum.json     |    1 +
>  rust/hw/char/pl011/vendor/syn/Cargo.toml      |  260 +
>  rust/hw/char/pl011/vendor/syn/LICENSE-APACHE  |  176 +
>  rust/hw/char/pl011/vendor/syn/LICENSE-MIT     |   23 +
>  rust/hw/char/pl011/vendor/syn/README.md       |  284 +
>  rust/hw/char/pl011/vendor/syn/benches/file.rs |   57 +
>  rust/hw/char/pl011/vendor/syn/benches/rust.rs |  182 +
>  rust/hw/char/pl011/vendor/syn/meson.build     |   24 +
>  rust/hw/char/pl011/vendor/syn/src/attr.rs     |  793 +++
>  rust/hw/char/pl011/vendor/syn/src/bigint.rs   |   66 +
>  rust/hw/char/pl011/vendor/syn/src/buffer.rs   |  434 ++
>  rust/hw/char/pl011/vendor/syn/src/classify.rs |  377 ++
>  .../pl011/vendor/syn/src/custom_keyword.rs    |  260 +
>  .../vendor/syn/src/custom_punctuation.rs      |  304 +
>  rust/hw/char/pl011/vendor/syn/src/data.rs     |  423 ++
>  rust/hw/char/pl011/vendor/syn/src/derive.rs   |  259 +
>  .../char/pl011/vendor/syn/src/discouraged.rs  |  225 +
>  rust/hw/char/pl011/vendor/syn/src/drops.rs    |   58 +
>  rust/hw/char/pl011/vendor/syn/src/error.rs    |  467 ++
>  rust/hw/char/pl011/vendor/syn/src/export.rs   |   73 +
>  rust/hw/char/pl011/vendor/syn/src/expr.rs     | 3960 +++++++++++++
>  rust/hw/char/pl011/vendor/syn/src/ext.rs      |  136 +
>  rust/hw/char/pl011/vendor/syn/src/file.rs     |  130 +
>  rust/hw/char/pl011/vendor/syn/src/fixup.rs    |  218 +
>  .../hw/char/pl011/vendor/syn/src/gen/clone.rs | 2209 +++++++
>  .../hw/char/pl011/vendor/syn/src/gen/debug.rs | 3160 ++++++++++
>  rust/hw/char/pl011/vendor/syn/src/gen/eq.rs   | 2242 +++++++
>  rust/hw/char/pl011/vendor/syn/src/gen/fold.rs | 3779 ++++++++++++
>  rust/hw/char/pl011/vendor/syn/src/gen/hash.rs | 2807 +++++++++
>  .../hw/char/pl011/vendor/syn/src/gen/visit.rs | 3858 ++++++++++++
>  .../pl011/vendor/syn/src/gen/visit_mut.rs     | 3855 ++++++++++++
>  rust/hw/char/pl011/vendor/syn/src/generics.rs | 1286 ++++
>  rust/hw/char/pl011/vendor/syn/src/group.rs    |  291 +
>  rust/hw/char/pl011/vendor/syn/src/ident.rs    |  108 +
>  rust/hw/char/pl011/vendor/syn/src/item.rs     | 3441 +++++++++++
>  rust/hw/char/pl011/vendor/syn/src/lib.rs      | 1019 ++++
>  rust/hw/char/pl011/vendor/syn/src/lifetime.rs |  156 +
>  rust/hw/char/pl011/vendor/syn/src/lit.rs      | 1830 ++++++
>  .../hw/char/pl011/vendor/syn/src/lookahead.rs |  169 +
>  rust/hw/char/pl011/vendor/syn/src/mac.rs      |  223 +
>  rust/hw/char/pl011/vendor/syn/src/macros.rs   |  166 +
>  rust/hw/char/pl011/vendor/syn/src/meta.rs     |  427 ++
>  rust/hw/char/pl011/vendor/syn/src/op.rs       |  219 +
>  rust/hw/char/pl011/vendor/syn/src/parse.rs    | 1397 +++++
>  .../pl011/vendor/syn/src/parse_macro_input.rs |  128 +
>  .../char/pl011/vendor/syn/src/parse_quote.rs  |  210 +
>  rust/hw/char/pl011/vendor/syn/src/pat.rs      |  953 +++
>  rust/hw/char/pl011/vendor/syn/src/path.rs     |  886 +++
>  .../char/pl011/vendor/syn/src/precedence.rs   |  163 +
>  rust/hw/char/pl011/vendor/syn/src/print.rs    |   16 +
>  .../char/pl011/vendor/syn/src/punctuated.rs   | 1132 ++++
>  .../char/pl011/vendor/syn/src/restriction.rs  |  176 +
>  rust/hw/char/pl011/vendor/syn/src/sealed.rs   |    4 +
>  rust/hw/char/pl011/vendor/syn/src/span.rs     |   63 +
>  rust/hw/char/pl011/vendor/syn/src/spanned.rs  |  118 +
>  rust/hw/char/pl011/vendor/syn/src/stmt.rs     |  481 ++
>  rust/hw/char/pl011/vendor/syn/src/thread.rs   |   60 +
>  rust/hw/char/pl011/vendor/syn/src/token.rs    | 1138 ++++
>  rust/hw/char/pl011/vendor/syn/src/tt.rs       |  107 +
>  rust/hw/char/pl011/vendor/syn/src/ty.rs       | 1216 ++++
>  rust/hw/char/pl011/vendor/syn/src/verbatim.rs |   33 +
>  .../char/pl011/vendor/syn/src/whitespace.rs   |   65 +
>  .../char/pl011/vendor/syn/tests/common/eq.rs  |  900 +++
>  .../char/pl011/vendor/syn/tests/common/mod.rs |   28 +
>  .../pl011/vendor/syn/tests/common/parse.rs    |   49 +
>  .../char/pl011/vendor/syn/tests/debug/gen.rs  | 5163 +++++++++++++++++
>  .../char/pl011/vendor/syn/tests/debug/mod.rs  |  147 +
>  .../char/pl011/vendor/syn/tests/macros/mod.rs |   93 +
>  .../char/pl011/vendor/syn/tests/regression.rs |    5 +
>  .../vendor/syn/tests/regression/issue1108.rs  |    5 +
>  .../vendor/syn/tests/regression/issue1235.rs  |   32 +
>  .../char/pl011/vendor/syn/tests/repo/mod.rs   |  461 ++
>  .../pl011/vendor/syn/tests/repo/progress.rs   |   37 +
>  .../pl011/vendor/syn/tests/test_asyncness.rs  |   43 +
>  .../pl011/vendor/syn/tests/test_attribute.rs  |  225 +
>  .../vendor/syn/tests/test_derive_input.rs     |  781 +++
>  .../char/pl011/vendor/syn/tests/test_expr.rs  |  692 +++
>  .../pl011/vendor/syn/tests/test_generics.rs   |  282 +
>  .../pl011/vendor/syn/tests/test_grouping.rs   |   53 +
>  .../char/pl011/vendor/syn/tests/test_ident.rs |   87 +
>  .../char/pl011/vendor/syn/tests/test_item.rs  |  332 ++
>  .../pl011/vendor/syn/tests/test_iterators.rs  |   70 +
>  .../char/pl011/vendor/syn/tests/test_lit.rs   |  331 ++
>  .../char/pl011/vendor/syn/tests/test_meta.rs  |  154 +
>  .../vendor/syn/tests/test_parse_buffer.rs     |  103 +
>  .../vendor/syn/tests/test_parse_quote.rs      |  166 +
>  .../vendor/syn/tests/test_parse_stream.rs     |  187 +
>  .../char/pl011/vendor/syn/tests/test_pat.rs   |  152 +
>  .../char/pl011/vendor/syn/tests/test_path.rs  |  130 +
>  .../pl011/vendor/syn/tests/test_precedence.rs |  537 ++
>  .../pl011/vendor/syn/tests/test_receiver.rs   |  321 +
>  .../pl011/vendor/syn/tests/test_round_trip.rs |  253 +
>  .../pl011/vendor/syn/tests/test_shebang.rs    |   67 +
>  .../char/pl011/vendor/syn/tests/test_size.rs  |   36 +
>  .../char/pl011/vendor/syn/tests/test_stmt.rs  |  322 +
>  .../vendor/syn/tests/test_token_trees.rs      |   32 +
>  .../hw/char/pl011/vendor/syn/tests/test_ty.rs |  397 ++
>  .../pl011/vendor/syn/tests/test_visibility.rs |  185 +
>  .../char/pl011/vendor/syn/tests/zzz_stable.rs |   33 +
>  .../vendor/unicode-ident/.cargo-checksum.json |    1 +
>  .../pl011/vendor/unicode-ident/Cargo.toml     |   63 +
>  .../pl011/vendor/unicode-ident/LICENSE-APACHE |  176 +
>  .../pl011/vendor/unicode-ident/LICENSE-MIT    |   23 +
>  .../vendor/unicode-ident/LICENSE-UNICODE      |   46 +
>  .../char/pl011/vendor/unicode-ident/README.md |  283 +
>  .../pl011/vendor/unicode-ident/benches/xid.rs |  124 +
>  .../pl011/vendor/unicode-ident/meson.build    |   14 +
>  .../pl011/vendor/unicode-ident/src/lib.rs     |  269 +
>  .../pl011/vendor/unicode-ident/src/tables.rs  |  651 +++
>  .../vendor/unicode-ident/tests/compare.rs     |   67 +
>  .../vendor/unicode-ident/tests/fst/mod.rs     |   11 +
>  .../unicode-ident/tests/fst/xid_continue.fst  |  Bin 0 -> 73249 bytes
>  .../unicode-ident/tests/fst/xid_start.fst     |  Bin 0 -> 65487 bytes
>  .../vendor/unicode-ident/tests/roaring/mod.rs |   21 +
>  .../vendor/unicode-ident/tests/static_size.rs |   95 +
>  .../vendor/unicode-ident/tests/tables/mod.rs  |    7 +
>  .../unicode-ident/tests/tables/tables.rs      |  347 ++
>  .../vendor/unicode-ident/tests/trie/mod.rs    |    7 +
>  .../vendor/unicode-ident/tests/trie/trie.rs   |  445 ++
>  .../vendor/version_check/.cargo-checksum.json |    1 +
>  .../pl011/vendor/version_check/Cargo.toml     |   24 +
>  .../pl011/vendor/version_check/LICENSE-APACHE |  201 +
>  .../pl011/vendor/version_check/LICENSE-MIT    |   19 +
>  .../char/pl011/vendor/version_check/README.md |   80 +
>  .../pl011/vendor/version_check/meson.build    |   14 +
>  .../pl011/vendor/version_check/src/channel.rs |  193 +
>  .../pl011/vendor/version_check/src/date.rs    |  203 +
>  .../pl011/vendor/version_check/src/lib.rs     |  493 ++
>  .../pl011/vendor/version_check/src/version.rs |  316 +
>  365 files changed, 108770 insertions(+)
>  create mode 100644 rust/hw/char/pl011/vendor/either/README.rst
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/CHANGELOG.md
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/LICENSE.txt
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/arbitrary-int/tests/tests.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize/split.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize_internal.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/bitsize_internal/struct_gen.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/debug_bits.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/default_bits.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/fmt_bits.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/from_bits.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/discriminant_assigner.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/fallback.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/shared/util.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge-impl/src/try_from_bits.rs
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/bilge/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/either/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/either/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/either/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/either/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/either/README-crates.io.md
>  create mode 100644 rust/hw/char/pl011/vendor/either/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/either/src/into_either.rs
>  create mode 100644 rust/hw/char/pl011/vendor/either/src/iterator.rs
>  create mode 100644 rust/hw/char/pl011/vendor/either/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/either/src/serde_untagged.rs
>  create mode 100644 rust/hw/char/pl011/vendor/either/src/serde_untagged_optional.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/CHANGELOG.md
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/Cargo.lock
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/bench1.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/combinations.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/combinations_with_replacement.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/extra/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/extra/zipslices.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/fold_specialization.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/powerset.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tree_fold1.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tuple_combinations.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/benches/tuples.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/examples/iris.data
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/examples/iris.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/coalesce.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/map.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/adaptors/multi_product.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/combinations.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/combinations_with_replacement.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/concat_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/cons_tuples_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/diff.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/duplicates_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/either_or_both.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/exactly_one_err.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/extrema_set.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/flatten_ok.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/format.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/free.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/group_map.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/groupbylazy.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/grouping_map.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/impl_macros.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/intersperse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/k_smallest.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/kmerge_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/lazy_buffer.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/merge_join.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/minmax.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/multipeek_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/pad_tail.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/peek_nth.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/peeking_take_while.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/permutations.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/powerset.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/process_results_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/put_back_n_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/rciter_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/repeatn.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/size_hint.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/sources.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/take_while_inclusive.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/tee.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/tuple_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/unique_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/unziptuple.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/with_position.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/zip_eq_impl.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/zip_longest.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/src/ziptuple.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/adaptors_no_collect.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/flatten_ok.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/macros_hygiene.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/merge_join.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/peeking_take_while.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/quick.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/specializations.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/test_core.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/test_std.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/tuples.rs
>  create mode 100644 rust/hw/char/pl011/vendor/itertools/tests/zip.rs
>  create mode 100644 rust/hw/char/pl011/vendor/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/build.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/parse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error-attr/src/settings.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/CHANGELOG.md
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/build.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/diagnostic.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/dummy.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/imp/delegate.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/imp/fallback.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/macros.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/src/sealed.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/macro-errors.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ok.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/runtime-errors.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/abort.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/abort.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/append_dummy.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/append_dummy.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/children_messages.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/children_messages.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/dummy.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/dummy.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/emit.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/emit.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/explicit_span_range.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/explicit_span_range.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/misuse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/misuse.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/multiple_tokens.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/multiple_tokens.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/not_proc_macro.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/not_proc_macro.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/option_ext.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/option_ext.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/proc_macro_hack.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/proc_macro_hack.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/result_ext.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/result_ext.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/to_tokens_span.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/to_tokens_span.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unknown_setting.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unknown_setting.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unrelated_panic.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro-error/tests/ui/unrelated_panic.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/build.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/build/probe.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/rust-toolchain.toml
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/detection.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/extra.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/fallback.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/location.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/marker.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/parse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/rcvec.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/src/wrapper.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/comments.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/features.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/marker.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test_fmt.rs
>  create mode 100644 rust/hw/char/pl011/vendor/proc-macro2/tests/test_size.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/quote/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/quote/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/quote/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/quote/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/quote/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/quote/rust-toolchain.toml
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/ext.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/format.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/ident_fragment.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/runtime.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/spanned.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/src/to_tokens.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/compiletest.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/test.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated-dup.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated-dup.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-interpolated.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-separated.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter-separated.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/does-not-have-iter.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-quotable.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-quotable.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-repeatable.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/not-repeatable.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/wrong-type-span.rs
>  create mode 100644 rust/hw/char/pl011/vendor/quote/tests/ui/wrong-type-span.stderr
>  create mode 100644 rust/hw/char/pl011/vendor/syn/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/syn/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/syn/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/syn/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/syn/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/syn/benches/file.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/benches/rust.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/attr.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/bigint.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/buffer.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/classify.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/custom_keyword.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/custom_punctuation.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/data.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/derive.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/discouraged.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/drops.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/error.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/export.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/expr.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/ext.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/file.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/fixup.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/clone.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/debug.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/eq.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/fold.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/hash.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/visit.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/gen/visit_mut.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/generics.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/group.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/ident.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/item.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/lifetime.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/lit.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/lookahead.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/mac.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/macros.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/meta.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/op.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse_macro_input.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/parse_quote.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/pat.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/path.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/precedence.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/print.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/punctuated.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/restriction.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/sealed.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/span.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/spanned.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/stmt.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/thread.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/token.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/tt.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/ty.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/verbatim.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/src/whitespace.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/eq.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/common/parse.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/debug/gen.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/debug/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/macros/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression/issue1108.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/regression/issue1235.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/repo/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/repo/progress.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_asyncness.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_attribute.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_derive_input.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_expr.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_generics.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_grouping.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_ident.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_item.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_iterators.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_lit.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_meta.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_buffer.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_quote.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_parse_stream.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_pat.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_path.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_precedence.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_receiver.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_round_trip.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_shebang.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_size.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_stmt.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_token_trees.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_ty.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/test_visibility.rs
>  create mode 100644 rust/hw/char/pl011/vendor/syn/tests/zzz_stable.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/LICENSE-UNICODE
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/benches/xid.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/src/tables.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/compare.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/xid_continue.fst
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/fst/xid_start.fst
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/roaring/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/static_size.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/tables/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/tables/tables.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/trie/mod.rs
>  create mode 100644 rust/hw/char/pl011/vendor/unicode-ident/tests/trie/trie.rs
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/.cargo-checksum.json
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/Cargo.toml
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/LICENSE-APACHE
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/LICENSE-MIT
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/README.md
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/meson.build
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/src/channel.rs
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/src/date.rs
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/src/lib.rs
>  create mode 100644 rust/hw/char/pl011/vendor/version_check/src/version.rs


