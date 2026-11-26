Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF06D606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=viETKLWT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi6y-0006ZE-Ip; Thu, 26 Nov 2026 17:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi6u-0006Yr-Bm
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:38:36 -0500
Received: from st-2001j-snip6-3.eps.apple.com ([2a01:b747:3001:206::67]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi6s-0000cS-R4
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:38:36 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 C79C218001A4; Thu, 26 Nov 2026 22:38:30 +0000 (UTC)
X-ICL-RepId: 01a21a02-a4a4-7972-89f4-074ee539634b
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795732712; x=1827268712;
 bh=/fa11WWNBRhlYs37bUggv87aiksrshFqflA4V2xK8Zc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=viETKLWTb97KG9596mJyLPgo7a2QAROi6moyLQvYJNpl2jDnVFbeaYBKdgHhlQdqGIXzQP2fz4fFCNX7SqySaki3bxVwNf+BHygnZE7Y6qkIKAhiASJvfKTd++AwfFffunVlKNrkZW09aoDnuDtVT2fytaNXb6thbfn8cCCsESJMuRnyo5Zic16iQ7AyNmlyKKx/wNmuDCKqjI1is5B6DCslF3iAYPOTlVSYNzPgELR/HzHmpVlIYAIwuBlWjkMV64yoVaFj/WtxA1yKufRCAJNc/VXtvN55hPioK9dMglXcB67rTrqO0Kw2PUzoqRflJEukRihWXGOlIoz4voAMbw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 597C918001B3; Thu, 26 Nov 2026 22:38:29 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v3 01/10] iotests: use gsed when necessary
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126190054.40844-2-bogorodskiy@gmail.com>
Date: Thu, 26 Nov 2026 23:38:16 +0100
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <510F6AC0-D14B-45B6-A94B-20049024BD68@unpredictable.fr>
References: <20261126190054.40844-1-bogorodskiy@gmail.com>
 <20261126190054.40844-2-bogorodskiy@gmail.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: H5lXLEWNBEVlPekMX77XoXrrotnRfFQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX9VGETwpnKiCv
 +cC1/V4435tX8XAkTRmQCTOtD+lj5c+i5SGitJXzgmPAcYaBJbplB8JXSqRKAu6PmS/Hszxs+8E
 G3xpGBY+6XpqoaOvqoAr22j+ch4Jc4NHqJIcae9h6Nbp3nkr+dE0ElMnrMALimNlby0dfG8r/y8
 1t+6sm0ENhAxv7CcbKRdTvPVuaYdaqDtc59CIE89t66VlUw3KNSa8cx6O+xxQMFQha+gLvFgaoY
 pjhuLbpji25Uz9lm3KoaRSNvbGQQhyQtCTD29BPPE+E+/O3d/RLUfKPQHE34Z5sx9nUWGLpRdSc
 RV/9GpVZzsMycOY9vvc3jLdrpb9zT0Dpkz/mi/BIBizaOpkp7YadW2LGLvP6hg=
X-Proofpoint-ORIG-GUID: H5lXLEWNBEVlPekMX77XoXrrotnRfFQ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX45QuaXVwLcQu
 agu7jPPvmbZ72RJSrpG06ALnCFlAbybGKkxXmh+umbRqdWSEyqkoJtNN8S80I+fSWGW5EcVwffA
 fiz3G47EZeJP2CbDt6VmO74pKiLTurs=
X-Authority-Info-Out: v=2.4 cv=S8FMU4sP c=1 sm=1 tr=0 ts=6b08b4e7
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=51JdnUhQRHFq8RItG6ly:22 a=beLEQGMwZPMEN1sKVEDc:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=gPyYNDQZOmDTyd3kigAA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABtei2fsWZf2Ech7dNEIxLfcF/7bCr7zYsBjx7Vahhs5dCpBSnppFItovOiILsen
 kOld/BlT6XrADJ1fNpWv5U6okhTIIBB/xt44Vm6xJ2lcmzZuzK2ZMtn/JjbC64l6VQ63wt
 qad1/Sz5lSICsUgRk8+2b5m4ogturAlKWmCPV371yNITE1+0eHDBEQxVPNk7g3K9hX4UHi
 zsRWfFbt+OvW24mQUscHOaxBDuw+SiMRHxiBa/hPIdL32wx+Mu37PMAvjtCYJ+CVkcSK/P
 dpjFabwng3URwXydpHJkgt1qXxo0yaL29TsfrcVHhzcIgXR702CBbkphb7LzlDIwCMo3hX
 4ccG2Q4QvtFX/HCjChoR8FFmsMhng1vVmr2OW/wU7ac1qAMU+Nv1WXfbhO6cmW1dIDiALM
 CEUNxXpfLVpBiuwnKSiEmICi0a7YAOjzGVzGR0TKquhppqbdYo8nH4TSiSbMMG4M7k6aXL
 uxwiOoQ0iPT43iLkVRi8UAbNViWbkBymAm0mZjbWEVzfxFWoi4GDClQYXjamHF+FZdG8I+
 gAET3vUiaiBZRU/kswPYGWtj6/weo45UXTwGFj/xDi5Naj16xFtjH07lUWp/dMWcBoWcAv
 xwpro9VXgVAZ2Shv0CDgUmxhk9Sj/LO0jiw1s9LeKa8JHtGrqM0R2kyC2Pj1RPp8wNMhUU
 BhqrGkCMVTqGcM8Yew0oa3HRD89IzyFgbUpycZ3SZZMgkYU65Lg4nN/78eau2v3MxM4gJ3
 J1I1gVFWcovP4xZSOydvtaSMgT7GNiT7hPNjeRDgyVNKwESvxpANT45yXvhX6UN8iM8Ry3
 0wrr6r1TVAf/pCbAAtmQQAC9FVBX7Mu9wNz402++SPk9BqhgUb4nkC2xrlHr5oDsm1PdKM
 NEA1hehM+yAZhPEnbqThVmRKGEHWHbCqAp9pPQjiP+4QfUlNlONdAMNYs50SM58HYVu4nc
 HCmwexb9endd7kW/AU/8DN/EJdfU5NYtVa6HtVunSEZk6HxtkZyKgSFSZkfJoBnARqnx/q
 TMQ/XpDoMvK2ztgPaMBXRH1YSe9U8//LsD2d6MtaeJBQvQihVrbAW1DYlme7jV2r6fUX5L
 efGmhuDb6j1/gQnbjbYjyxpIjLGKnLJxakspf2/Da0LMxbfNWL3Sz7WUwWrvZy1OLCCAJt
 CjtQZqBoptQSBltLzBtnrPhQQ3JvwlnONxs5xQsploVbgUBprSUc8ad5LuYUDmVGt9w1AQ
 TJ4ADXLdfTCv1HAQxI/5Y2waeiSLz84kgfMBxkCcdesMGpY4mczfGrkKQ5OyxZA8MGtZhG
 OtMFPkGMnRNNQqsGqtfNmnDFM5tCR/Vek78ou7t7ibRxZDguZxQo55Nbgbmx22nZ08Rqtd
 uNYAwOY7jxVkEnXY1FTevVQPHjexedw=
Received-SPF: pass client-ip=2a01:b747:3001:206::67;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26. Nov 2026, at 20:00, Roman Bogorodskiy <bogorodskiy@gmail.com> =
wrote:
>=20
> Some iotests fail on FreeBSD because the tests call sed
> directly, and BSD sed is not always compatible with GNU sed.
> As common.rc already provides the gsed() wrapper, use it
> instead if needed.
>=20
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>

> ---
> tests/qemu-iotests/115           | 2 +-
> tests/qemu-iotests/common.filter | 6 +++---
> 2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/115 b/tests/qemu-iotests/115
> index 5c8a12f85a..e3ff91de7a 100755
> --- a/tests/qemu-iotests/115
> +++ b/tests/qemu-iotests/115
> @@ -78,7 +78,7 @@ _make_test_img -o =
"refcount_bits=3D64,cluster_size=3D512,preallocation=3Dmetadata" 256
> # qemu-img check for that purpose, too.
>=20
> $QEMU_IMG check "$TEST_IMG" | \
> -    sed -e 's/^.* =3D \([0-9]\+\.[0-9]\+% =
allocated\).*\(clusters\)$/\1 \2/' \
> +    gsed -e 's/^.* =3D \([0-9]\+\.[0-9]\+% =
allocated\).*\(clusters\)$/\1 \2/' \
>         -e '/^Image end offset/d'
>=20
> # (Note that we cannot use _check_test_img because that function =
filters out the
> diff --git a/tests/qemu-iotests/common.filter =
b/tests/qemu-iotests/common.filter
> index ce4213cb97..f7211a0a29 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -130,7 +130,7 @@ _filter_actual_image_size()
> # Filename filters for qemu-img create
> _filter_img_create_filenames()
> {
> -    sed \
> +    gsed \
>         -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>         -e "s#$TEST_DIR#TEST_DIR#g" \
> @@ -296,7 +296,7 @@ _filter_qemu_img_map()
>         data_file_filter=3D(-e "s#$data_file_pattern#\\1#")
>     fi
>=20
> -    sed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
> +    gsed -e 's/\([0-9a-fx]* *[0-9a-fx]* *\)[0-9a-fx]* */\1/g' \
>         -e 's/"offset": [0-9]\+/"offset": OFFSET/g' \
>         -e 's/Mapped to *//' \
>         "${data_file_filter[@]}" \
> @@ -310,7 +310,7 @@ _filter_nbd()
>     # receive callbacks sometimes, making them unreliable.
>     #
>     # Filter out the TCP port number since this changes between runs.
> -    sed -e '/nbd\/.*\.c:/d' \
> +    gsed -e '/nbd\/.*\.c:/d' \
>         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
>         -e 's#localhost:[0-9]*#localhost:PORT#g' \
>         -e =
's#host=3D127\.0\.0\.1,port=3D[0-9]*#host=3D127.0.0.1,port=3DPORT#g' \
> --=20
> 2.56.0
>=20
>=20


