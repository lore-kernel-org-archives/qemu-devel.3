Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C7BD43FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 08:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCxKV-0004Lk-UJ; Mon, 18 Nov 2024 03:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daoudlamalmi@pm.me>)
 id 1tCuaB-00036Z-1N
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 00:45:57 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daoudlamalmi@pm.me>)
 id 1tCua8-0006gL-Qq
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 00:45:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1731908745; x=1732167945;
 bh=stqlWgQgInhHASze49xjgsF8+Ns3jQ3GoRU4AkPjMcw=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=Bnn+vKBzXj1BLP+xT9/rEXGs1GPSGuDiMrKA1Oipklobk5Ub4ECzd+JKsVZAtSlYn
 jeLz1hAfHF7irbtLMrjW0WiCmZgp3ITWgMresbbGpegIEVdvBjw0Wj9oONP1hfQElW
 jBPkB6bSwLfCdeWSKGbZvgcUjDcoCaixitBCmMkCBiQorK0lpuIUpCgJJOR8eaI3VK
 iplNNNGtuXSwRr7LjnCdWwwxEQ8u2tIx0CwiXre36hs+TO/FLwwRo1F0GRlUM1XnnN
 IWqqytesmb8y4bqKjGh85oDcUjYJADJsha4NCi6PEAN5tUa/yRaGOM2C5Ixisui1BC
 KML2NnvBnR8VQ==
Date: Mon, 18 Nov 2024 05:45:41 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: MPC5553/MPC5554 Emulation (information request)
Message-ID: <kvndhk2oZokSDFW29-5pef8r1zmug70mTlHmrKT99LrvOaAflAeBV-vD6I6BAiAkHavpsN23lKJ6mN4Bd7UYFDe2tgbSegrXYVK6p-tR5F4=@pm.me>
Feedback-ID: 123214895:user:proton
X-Pm-Message-ID: cd35a153071f3bf303255e40702d674edd98a4dd
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha512;
 boundary="------f8c8c4c65c6b1f3ba45302bd436eec672b0dd6d02b2d9d3340a3ba4b5634a7cd";
 charset=utf-8
Received-SPF: pass client-ip=185.70.40.134; envelope-from=daoudlamalmi@pm.me;
 helo=mail-40134.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 Nov 2024 03:41:44 -0500
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
Reply-to:  Daoud LAMALMI <daoudlamalmi@pm.me>
From:  Daoud LAMALMI via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------f8c8c4c65c6b1f3ba45302bd436eec672b0dd6d02b2d9d3340a3ba4b5634a7cd
Content-Type: multipart/mixed;boundary=---------------------d0e10408bb929648c2fa48dd152afe89

-----------------------d0e10408bb929648c2fa48dd152afe89
Content-Type: multipart/alternative;boundary=---------------------dbd6039b9557699868def7bcbaaa1617

-----------------------dbd6039b9557699868def7bcbaaa1617
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Goal
----

I'd like to know if it is planned for QEMU to be able to emulate the MPC55=
53/MPC5554 microcontrollers.

Technical details
-----------------

I know that the e200z6 processor can already be emulated. I don't know how=
 much work is needed to emulate those microcontrollers fully based on the =
work that has already been done.

Additional information
----------------------

If it is not planned, I'll most likely start educating myself on this proj=
ect to try and patch it in as it's a need that is quite important for me. =
I'll try not to waste your time and read as much as I can about your guide=
lines. Would you advise me against trying to do this? I'd like to know how=
 hard you think this will be.

DISCLAIMER : I am still very much a newbie in embedded systems, I'm only i=
n the first year of my master's degree in embedded systems.

Sent with Proton Mail secure email.
-----------------------dbd6039b9557699868def7bcbaaa1617
Content-Type: multipart/related;boundary=---------------------d39bbbeede525ceee9202b9e04235c53

-----------------------d39bbbeede525ceee9202b9e04235c53
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48ZGl2IGRhdGEtdGVzdGlkPSJnZm0tY29udGVudCI+PGgyIGRpcj0iYXV0byIgZGF0YS1z
b3VyY2Vwb3M9IjE3OjEtMTc6NyI+R29hbDwvaDI+PHAgZGlyPSJhdXRvIiBkYXRhLXNvdXJjZXBv
cz0iMTk6MS0xOToxMDIiPkknZCBsaWtlIHRvIGtub3cgaWYgaXQgaXMgcGxhbm5lZCBmb3IgUUVN
VSB0byBiZSBhYmxlIHRvIGVtdWxhdGUgdGhlIE1QQzU1NTMvTVBDNTU1NCBtaWNyb2NvbnRyb2xs
ZXJzLjwvcD48aDIgZGlyPSJhdXRvIiBkYXRhLXNvdXJjZXBvcz0iMjE6MS0yMToyMCI+PGE+PC9h
PlRlY2huaWNhbCBkZXRhaWxzPC9oMj48cCBkaXI9ImF1dG8iIGRhdGEtc291cmNlcG9zPSIyMzox
LTI0OjEyMiI+SSBrbm93IHRoYXQgdGhlIGUyMDB6NiBwcm9jZXNzb3IgY2FuIGFscmVhZHkgYmUg
ZW11bGF0ZWQuCkkgZG9uJ3Qga25vdyBob3cgbXVjaCB3b3JrIGlzIG5lZWRlZCB0byBlbXVsYXRl
IHRob3NlIG1pY3JvY29udHJvbGxlcnMgZnVsbHkgYmFzZWQgb24gdGhlIHdvcmsgdGhhdCBoYXMg
YWxyZWFkeSBiZWVuIGRvbmUuPC9wPjxoMiBkaXI9ImF1dG8iIGRhdGEtc291cmNlcG9zPSIyNjox
LTI2OjI1Ij48YT48L2E+QWRkaXRpb25hbCBpbmZvcm1hdGlvbjwvaDI+PHAgZGlyPSJhdXRvIiBk
YXRhLXNvdXJjZXBvcz0iMjg6MS0zMTo0OSI+SWYgaXQgaXMgbm90IHBsYW5uZWQsIEknbGwgbW9z
dCBsaWtlbHkgc3RhcnQgZWR1Y2F0aW5nIG15c2VsZiBvbiB0aGlzIHByb2plY3QgdG8gdHJ5IGFu
ZCBwYXRjaCBpdCBpbiBhcyBpdCdzIGEgbmVlZCB0aGF0IGlzIHF1aXRlIGltcG9ydGFudCBmb3Ig
bWUuCkknbGwgdHJ5IG5vdCB0byB3YXN0ZSB5b3VyIHRpbWUgYW5kIHJlYWQgYXMgbXVjaCBhcyBJ
IGNhbiBhYm91dCB5b3VyIGd1aWRlbGluZXMuCldvdWxkIHlvdSBhZHZpc2UgbWUgYWdhaW5zdCB0
cnlpbmcgdG8gZG8gdGhpcz8KSSdkIGxpa2UgdG8ga25vdyBob3cgaGFyZCB5b3UgdGhpbmsgdGhp
cyB3aWxsIGJlLjwvcD48cCBkaXI9ImF1dG8iIGRhdGEtc291cmNlcG9zPSIzMzoxLTMzOjEzMyI+
RElTQ0xBSU1FUiA6IEkgYW0gc3RpbGwgdmVyeSBtdWNoIGEgbmV3YmllIGluIGVtYmVkZGVkIHN5
c3RlbXMsIEknbSBvbmx5IGluIHRoZSBmaXJzdCB5ZWFyIG9mIG15IG1hc3RlcidzIGRlZ3JlZSBp
biBlbWJlZGRlZCBzeXN0ZW1zLjwvcD48L2Rpdj48L2Rpdj4KPGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7IiBjbGFzcz0icHJvdG9ubWFp
bF9zaWduYXR1cmVfYmxvY2siPgogICAgPGRpdiBjbGFzcz0icHJvdG9ubWFpbF9zaWduYXR1cmVf
YmxvY2stdXNlciBwcm90b25tYWlsX3NpZ25hdHVyZV9ibG9jay1lbXB0eSI+CgogICAgICAgICAg
ICA8L2Rpdj4KCiAgICAgICAgICAgIDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Js
b2NrLXByb3RvbiI+CiAgICAgICAgU2VudCB3aXRoIDxhIGhyZWY9Imh0dHBzOi8vcHJvdG9uLm1l
L21haWwvaG9tZSIgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29w
ZW5lciI+UHJvdG9uIE1haWw8L2E+IHNlY3VyZSBlbWFpbC4KICAgIDwvZGl2Pgo8L2Rpdj4K
-----------------------d39bbbeede525ceee9202b9e04235c53--

-----------------------dbd6039b9557699868def7bcbaaa1617--

-----------------------d0e10408bb929648c2fa48dd152afe89
Content-Type: application/pgp-keys; filename="publickey - daoudlamalmi@pm.me - 0xFA411EFC.asc"; name="publickey - daoudlamalmi@pm.me - 0xFA411EFC.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - daoudlamalmi@pm.me - 0xFA411EFC.asc"; name="publickey - daoudlamalmi@pm.me - 0xFA411EFC.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnhDeUJCWUpLd1lCQkFI
YVJ3OEJBUWRBbXREU25mZHVwNFBjTndqK2hJZ0VYVWxDTGh0N3VuWVMKOUVJYUMxcTczYXJOSjJS
aGIzVmtiR0Z0WVd4dGFVQndiUzV0WlNBOFpHRnZkV1JzWVcxaGJHMXBRSEJ0CkxtMWxQc0tNQkJB
V0NnQStCWUpuRUxJRUJBc0pCd2dKa0VMamtMTURsYmxDQXhVSUNnUVdBQUlCQWhrQgpBcHNEQWg0
QkZpRUUra0VlL0hMTStNN1VPZlU2UXVPUXN3T1Z1VUlBQUQ2a0FQNDk3TmhwaTlPYURYSHkKekRa
b3lyNVpsSVRLbTFJS3loMW1RVllxenltWk5nRUE1aFJtc2tGOXZoMnVQWTVtU1lHMzg4ODVVTUZY
Cjd2bWlnd0NEVFRBRFJnTE9PQVJuRUxJRUVnb3JCZ0VFQVpkVkFRVUJBUWRBM3RBem1zTTB4OGp6
SEFVKwpKNjYwTVd0RnN2UVkzbFBmK3hiblUvVE1RUllEQVFnSHduZ0VHQllLQUNvRmdtY1FzZ1FK
a0VMamtMTUQKbGJsQ0Fwc01GaUVFK2tFZS9ITE0rTTdVT2ZVNlF1T1Fzd09WdVVJQUFLWTRBUURD
SHdLQkVzTWpROU5mCm1MWWphOXk1RDV5VTkzYW04aVNnOVY5M3NPZGQrZ0VBbXpNUGcrY0ZFRU5X
emFJTTkvTjMrWTBnK1N0RwpuV1o3WW4zNnBGajhtZ3c9Cj1ISXlKCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0K
-----------------------d0e10408bb929648c2fa48dd152afe89--

--------f8c8c4c65c6b1f3ba45302bd436eec672b0dd6d02b2d9d3340a3ba4b5634a7cd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc61GwJkELjkLMDlblCFiEE+kEe/HLM+M7UOfU6QuOQswOV
uUIAADHFAQCSJW5FsLUJBCjWYoluShj8zQ+GBi9SoYz8lw/gpMCHIwD/TsOb
VlGAjEeHKldB0WTSSfUNZqZrbnaa1hWyL/kiYgk=
=k32l
-----END PGP SIGNATURE-----


--------f8c8c4c65c6b1f3ba45302bd436eec672b0dd6d02b2d9d3340a3ba4b5634a7cd--


