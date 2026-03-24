Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C72FEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w57Jh-0004tx-2q; Tue, 24 Mar 2026 15:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w57JX-0004tA-1T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:21:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w57JT-0003VB-4Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:21:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCxOJ2340473
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=L4AOhCtP7TolSCLQjrC+qblm
 5AqFo7SPEhmxPoyq8kk=; b=JkWeu331w6N5VlF7KaKDEAUH+oNXYkmy727ErA59
 4VQ4TEcdgGGk3M3bnytbA43kUNwh733pERRBg1FZgh5gcFhNdyTMnR6MzMJWJCK0
 PENpIIqw6fstWm07AVlOxNpBKt9dAVzL0qvh5uv+C6FoPVShR0FFRcuTMJAKkVrO
 iQF5YLqCdw5hnvuGuThCKaXUDvZscc+r9KDmhET9+925TQTD0v3/XaohGtk9QAQ2
 ZilqPxYILALhj8VkCqWOC4uLMwh6JULBAkKgWDb4g6+ZeZrzKgDBMN4VUdiSe86f
 goZPJs8xkVwupGK07Hj4I0EFV21X5pSlaOhD3KIoqqJbvw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw41x80-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:21:06 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-798531a0f58so96968277b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774380066; cv=none;
 d=google.com; s=arc-20240605;
 b=e5s7SpNgzGYPxCB0J+QdmubgOWkdk3IzIXU/m7418P95KTpP8v0Pp+pu9Bv9ZYJta3
 1N8PKkB3lSimwDT45poWVZK9mOA8i08Sdo43T368Ms+Rm807Mi9L2rareQqy1E06zKgl
 rKvLR43AMC+NbI/dhI0YS5MRxsvI4RkpXph/S7TJhmgjypNN0iMGyzvRV1haanKwm8f4
 Jbz9YcfJbG/ETRDcTjNkj4dQ29jeWkx8dt/ut+I0or+IS12skcXjS8W0RfEDGiYdfcVT
 MKQ6fAfjHTGfHAhKhaACg66Wf2vdYgxESsby8EUWVAcQkLFuJ6p/85InmA42NdwfnoT8
 OHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L4AOhCtP7TolSCLQjrC+qblm5AqFo7SPEhmxPoyq8kk=;
 fh=WCfLL/xeDYfJcAViu6AnwFqIv+MscG3uTRvV6QOCuDc=;
 b=Hw4sXJSd2qMCbFqSYMqsYM85k58ExS07FZKiycGZef/Vhpv+AhTqqpFuK8l5HazRK/
 DGmwp0i3yJE21bsKxmzpwjzK3yeYakvM4Qg7K6vYSOR9k+4o8cEyVdn6bTCe0XlyWjxV
 grsbpzCdwKRSUn7JleSDMNbLpnPOPOzSGS72eqgZSQlMEHH9GQdn8OD02k6FW9vnHHSV
 /Ny+c52glixb5lr+FaTqRdviiBHAHlx1EFIVDxNhSnrBOVZw7B/gtltzce9yJCizixsT
 UGvfskWJjEvpE0YDZzH/JD3jTuSE9P3rYKd5qVcla/NJwZdaM5XV7ZBYitCKYULobCVc
 j1CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774380066; x=1774984866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L4AOhCtP7TolSCLQjrC+qblm5AqFo7SPEhmxPoyq8kk=;
 b=cgdzwWXytkiknqJFbSGptRSx+jbDX9YQ8feI0uaDG8QzTB6mUUUnOjgq2CyDSh+84D
 KhToj8D7R9ZF+eE19ZE2bugv52rEwMfSzDu0i+A1Mvwni0SrO9sALD3ntcYEhKqROaBD
 nV1hwi9nt+HgsTIYK7CRRKqmKqQhQkeVrkrfCygjvN/C2uRPWBAc087qG9DOW+wFxCOx
 snidGew0hJeZ/lXb8JF8ZtuKX6LKppEhQwYpr9Oy1gVrJNrMMuJtSehUwbGrx8Lns+XP
 JUhIsbltRHDNN5Om6QPthB8MnE2F554NabGdgXKyn1spdaNbQpYr5cCzRGjdxGNo3Qs5
 AaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774380066; x=1774984866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4AOhCtP7TolSCLQjrC+qblm5AqFo7SPEhmxPoyq8kk=;
 b=kSe69Gh/5CkdcjSNSJvhAfgvNRtF2mZns58Qwq6l/mp30mlLiC7mk52BGp6w1iK+DA
 1Lffzj20xV5s1V8qDet6WAf4H0tfjFsaNLvWULuLJYruf4XvvGrstkUq7cw1dgoSJxew
 kW8+Q5hlUB/2VDw2gvlvrk6tgGl53dLeycD91RIHyQ0YTmR5xqi44vg7A6LxUaQNRe6I
 /hnCOUXUMdNhXTkDn9TU7gAChzWN+9vB+2kspsLIVQ5dvQeYY59RaeCRK6l0WPF/A8ps
 8MfMXbnXsL/FrXmKuFFbE67tN7YYK4YPkyE7zSz+kfM9ZXRNsOmKJH9CSgTPasg5TrLm
 MdYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKGYGksjneg9o63tSVfhGaSqBiL7lfUHFvDRx+1ZvvYJQm3wwZsNSIhp0s/IM03lF3n+csK2K3oqi@nongnu.org
X-Gm-Message-State: AOJu0Yw60rJPc5FUKb5Gu9cTrY1l5DZ3jYLrxvZgg14BgZzp1X5S1K4n
 vSw4ckUbVM9WDRmQcJp5zjzOZzgyEbG2oqr3N7Iu8vEK3B7UY0q0yJ6566Rmyzu81uzF00OEq+t
 9cpDKsO6+V5mlcMV9+ZGm04fShe1GJzUjapWk4YPXacefuXJbZ8P22nsJkU4pVLuCP5Kpuvswt8
 UEcQlKmX9IdmVFG22Xbx0iAgPEXXPWyLPgkKPS3fEK
X-Gm-Gg: ATEYQzwSVfxlNYrMJ3PVrY9DG91gZvS6QqM8/c9jV0C3SifBPy2rfI0ncWEL57PgVFK
 OcoQnkevEgm6jiQmpGMBWoYuF6QtagfQmYXzBaMElOl+QCrCZRWLjZ8hdpVpY3vQ1K0iEsQ/py+
 LY2Qta/tfTiGNOhRHTec6jNYIloPN950faVoQfxleGoMedsrCyRVMZ1A0owqu3fMp36fT9Ovm/u
 pFZCHg=
X-Received: by 2002:a05:690e:1688:b0:644:7933:ae8a with SMTP id
 956f58d0204a3-64ee606f42cmr678643d50.16.1774380065692; 
 Tue, 24 Mar 2026 12:21:05 -0700 (PDT)
X-Received: by 2002:a05:690e:1688:b0:644:7933:ae8a with SMTP id
 956f58d0204a3-64ee606f42cmr678620d50.16.1774380065175; Tue, 24 Mar 2026
 12:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
 <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
 <CAATN3Nq+BSfAFrCfFEfsOWaSt2JsHC4hVm+K5hJts-iAF83wTg@mail.gmail.com>
In-Reply-To: <CAATN3Nq+BSfAFrCfFEfsOWaSt2JsHC4hVm+K5hJts-iAF83wTg@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 14:20:49 -0500
X-Gm-Features: AaiRm51Ga0pfhl1VFaQG4lTp_vdL478nKl_gNSUnFHoe6I817-grgIRDJJwNN_g
Message-ID: <CAEqNhNa2ner=c6Zb-TYVTJ7Foa=quSRYG3MVHn6kpmG4OCGfxg@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="0000000000007b4f53064dca0dc7"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1MCBTYWx0ZWRfX4szli4plbfYv
 YF9WT9Cp92MfQundgw/dVz3U39HhJet2zluJQ9IPKpkyDdcjZxqN9+XlMmkdlEMyPTd4FRzo9sD
 5g3z3X2RHuzMn1cWRD9KEvf+9PAY4CF2S0bof5p1emyLCbowZwMX1V/1NcDiSWv+Tp5IO3FQGsm
 cEsvr/GdSutWEp+d2EjybZgAd0hVUUfaFsf20Q2G31Z0Lt4jIZ4E+vUXfNtwJ1bARfceqcXsgvD
 pdlJhD29UgKwTds2pCdPJRryZNfCQAAi6eLnSS9GraSXPCh7d02Rt3qyjUtDn1OrQEjECaXV0x+
 FxwEbYxhgHv6gGb7O43CbMNAKqoMFRlEkBN5pokZieDSC412w3YletaM1IJwBTVvBIc30IvOuM2
 KBE6NKUVyb0NnPq0jKgUxJavTGUxRTjC9Q4O7uoGQLuX0w6GHspWWNWlQLmcUXqi6XDnXrlRaXJ
 P33PWmyOs6p9zFSBhlw==
X-Proofpoint-GUID: pg6ChUu8c37x4u-JxRfJ-kU-WQkhafQh
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c2e422 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=TSMIHEEeEJxFve34Y5IA:9 a=QEXdDO2ut3YA:10
 a=FasEbcwPDtdxcebXxmEA:9 a=PAMN38yMwy1OGqtI:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: pg6ChUu8c37x4u-JxRfJ-kU-WQkhafQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240150
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

--0000000000007b4f53064dca0dc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 1:48=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

>
>
> On Tue, Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino <
> matheus.bernardino@oss.qualcomm.com> wrote:
>
>> On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson <ltaylorsimpson@g=
mail.com>
>> wrote:
>> >
>> >
>> >
>> > On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <
>> matheus.bernardino@oss.qualcomm.com> wrote:
>> >>
>> >> This flag will be used to control the HVX IEEE float instructions,
>> which
>> >> are only available at some Hexagon cores. When unavailable, the
>> >> instruction is essentially treated as a no-op.
>> >>
>> >> Signed-off-by: Matheus Tavares Bernardino <
>> matheus.bernardino@oss.qualcomm.com>
>> >> ---
>> >>  target/hexagon/cpu.h             |  1 +
>> >>  target/hexagon/translate.h       |  1 +
>> >>  target/hexagon/attribs_def.h.inc |  3 +++
>> >>  target/hexagon/cpu.c             |  1 +
>> >>  target/hexagon/decode.c          | 22 ++++++++++++++++++++++
>> >>  target/hexagon/translate.c       |  1 +
>> >>  6 files changed, 29 insertions(+)
>> >>
>> >>
>> >> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
>> >> index dbc9c630e8..d832a64a17 100644
>> >> --- a/target/hexagon/decode.c
>> >> +++ b/target/hexagon/decode.c
>> >> @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pkt)
>> >>      return !bitmap_empty(conflict, 32);
>> >>  }
>> >>
>> >> +static void convert_to_nop(Insn *insn)
>> >> +{
>> >> +    bool is_endloop =3D insn->is_endloop;
>> >> +    memset(insn, 0, sizeof(*insn));
>> >> +    insn->opcode =3D A2_nop;
>> >> +    insn->new_read_idx =3D -1;
>> >> +    insn->dest_idx =3D -1;
>> >> +    insn->generate =3D opcode_genptr[insn->opcode];
>> >> +    insn->iclass =3D 0b111;
>> >> +    insn->is_endloop =3D is_endloop;
>> >> +}
>> >> +
>> >>  /*
>> >>   * decode_packet
>> >>   * Decodes packet with given words
>> >> @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int
>> max_words, const uint32_t *words,
>> >>          /* Ran out of words! */
>> >>          return 0;
>> >>      }
>> >> +
>> >> +    /* Disable HVX IEEE instruction if extension is disabled. */
>> >> +    if (!ctx->ieee_fp_extension) {
>> >> +        for (i =3D 0; i < num_insns; i++) {
>> >> +            if (GET_ATTRIB(pkt->insn[i].opcode, A_HVX_IEEE_FP)) {
>> >> +                convert_to_nop(&pkt->insn[i]);
>> >> +            }
>> >> +        }
>> >> +    }
>> >> +
>> >
>> >
>> > Better to leave the instruction alone and turn it into a nop by not
>> generating any TCG.
>> >
>> > That way, the disassembly (-d in_asm) will still show what's actually
>> in the binary.  You could add the check in gen_tcg_funcs.py.
>> >
>> > You could also consider adding some sort of marker in the disassembly
>> to indicate that the flag is needed for the instruction to do anything.
>>
>> Ah, good idea. Will do both for the next round, thanks.
>>
>
> Note that we'll need to be careful with packets that use the result vecto=
r
> in a .new context.  For example
>     { V0.sf =3D vadd(V1.sf,V2.sf)
>       vmem(R19+#0x0) =3D V0.new }
> The problem is that the store wants to read the value from future_VRegs.
> However, if the vadd is  nop, there is junk in future_VRegs.  So, we'll
> either have to get the store to read from the real VRegs or have the vadd
> copy the old value of the destination into the future_VRegs value.  The
> first option will be more efficient because it will avoid the vector copy=
.
>
>
For the sake of ease-of-verification we'll want to do whatever the ISS
does.  It's not very obvious to me what it would do in this packet context
based on the description of the nop-like behavior, but we'll follow the
ISS' lead.  In practical terms the garbage in future_VRegs is probably just
as bad or good as any other value - if you bothered to execute this packet
on the target w/o support for this opcode you probably don't care much
about the result.



> We should also add a test to fp_hvx_disabled for this case.
>
> HTH,
> Taylor
>

--0000000000007b4f53064dca0dc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 24, 2026 at=
 1:48=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.=
com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@os=
s.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson &lt;<a=
 href=3D"mailto:ltaylorsimpson@gmail.com" target=3D"_blank">ltaylorsimpson@=
gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino &lt=
;<a href=3D"mailto:matheus.bernardino@oss.qualcomm.com" target=3D"_blank">m=
atheus.bernardino@oss.qualcomm.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; This flag will be used to control the HVX IEEE float instructions,=
 which<br>
&gt;&gt; are only available at some Hexagon cores. When unavailable, the<br=
>
&gt;&gt; instruction is essentially treated as a no-op.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:ma=
theus.bernardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss=
.qualcomm.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/attribs_def.h.inc |=C2=A0 3 +++<br>
&gt;&gt;=C2=A0 target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 1 +<br>
&gt;&gt;=C2=A0 target/hexagon/decode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
22 ++++++++++++++++++++++<br>
&gt;&gt;=C2=A0 target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 1 +<br>
&gt;&gt;=C2=A0 6 files changed, 29 insertions(+)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c<br>
&gt;&gt; index dbc9c630e8..d832a64a17 100644<br>
&gt;&gt; --- a/target/hexagon/decode.c<br>
&gt;&gt; +++ b/target/hexagon/decode.c<br>
&gt;&gt; @@ -696,6 +696,18 @@ static bool pkt_has_write_conflict(Packet *pk=
t)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 return !bitmap_empty(conflict, 32);<br>
&gt;&gt;=C2=A0 }<br>
&gt;&gt;<br>
&gt;&gt; +static void convert_to_nop(Insn *insn)<br>
&gt;&gt; +{<br>
&gt;&gt; +=C2=A0 =C2=A0 bool is_endloop =3D insn-&gt;is_endloop;<br>
&gt;&gt; +=C2=A0 =C2=A0 memset(insn, 0, sizeof(*insn));<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;opcode =3D A2_nop;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;new_read_idx =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;dest_idx =3D -1;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;generate =3D opcode_genptr[insn-&gt;opcode=
];<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;iclass =3D 0b111;<br>
&gt;&gt; +=C2=A0 =C2=A0 insn-&gt;is_endloop =3D is_endloop;<br>
&gt;&gt; +}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 /*<br>
&gt;&gt;=C2=A0 =C2=A0* decode_packet<br>
&gt;&gt;=C2=A0 =C2=A0* Decodes packet with given words<br>
&gt;&gt; @@ -746,6 +758,16 @@ int decode_packet(DisasContext *ctx, int max_=
words, const uint32_t *words,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Ran out of words! */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Disable HVX IEEE instruction if extension is dis=
abled. */<br>
&gt;&gt; +=C2=A0 =C2=A0 if (!ctx-&gt;ieee_fp_extension) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; num_insns; i++) =
{<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (GET_ATTRIB(pkt-&gt;=
insn[i].opcode, A_HVX_IEEE_FP)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 convert_t=
o_nop(&amp;pkt-&gt;insn[i]);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt; +<br>
&gt;<br>
&gt;<br>
&gt; Better to leave the instruction alone and turn it into a nop by not ge=
nerating any TCG.<br>
&gt;<br>
&gt; That way, the disassembly (-d in_asm) will still show what&#39;s actua=
lly in the binary.=C2=A0 You could add the check in gen_tcg_funcs.py.<br>
&gt;<br>
&gt; You could also consider adding some sort of marker in the disassembly =
to indicate that the flag is needed for the instruction to do anything.<br>
<br>
Ah, good idea. Will do both for the next round, thanks.<br></blockquote><di=
v><br></div><div>Note that we&#39;ll need to be careful with packets that u=
se the result vector in a .new context.=C2=A0 For example</div><div>=C2=A0 =
=C2=A0 {	V0.sf =3D vadd(V1.sf,V2.sf)<br>=C2=A0 =C2=A0 =C2=A0 vmem(R19+#0x0)=
 =3D V0.new }</div><div>The problem is that the store wants to read the val=
ue from future_VRegs.=C2=A0 However, if the vadd is=C2=A0 nop, there is jun=
k in future_VRegs.=C2=A0 So, we&#39;ll either have to get the store to read=
 from the real VRegs or have the vadd copy the old value of the destination=
 into the future_VRegs value.=C2=A0 The first option will be more efficient=
 because it will avoid the vector copy.</div><div><br></div></div></div></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace">For the sake of ease-of-verification we&#39;ll want to do w=
hatever the ISS does.=C2=A0 It&#39;s not very obvious to me what it would d=
o in this packet context based on the description of the nop-like behavior,=
 but we&#39;ll follow the ISS&#39; lead.=C2=A0 In practical terms the garba=
ge in future_VRegs is probably just as bad or good as any other value - if =
you bothered to execute this packet on the target w/o support for this opco=
de you probably don&#39;t care much about the result.</div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_quote"><div></div><div>We should also add a test to=
 fp_hvx_disabled for this case.</div><div><br></div><div>HTH,</div><div>Tay=
lor</div></div></div>
</blockquote></div></div>

--0000000000007b4f53064dca0dc7--

