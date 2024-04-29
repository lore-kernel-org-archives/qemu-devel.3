Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A28C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Hwm-0002Wc-PW; Sun, 28 Apr 2024 23:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hwh-0002W5-CA; Sun, 28 Apr 2024 23:44:51 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1Hwe-00078p-1i; Sun, 28 Apr 2024 23:44:51 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7e61a25900cso1212257241.3; 
 Sun, 28 Apr 2024 20:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362285; x=1714967085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAB1/rbCC1p7W1eT4OXUmC8EUcIq+kxWaDPBAPzPEtg=;
 b=EB48dA3UXvc+KXdz+hpDUOwWq8gKfXtOB9l9gbMXlOCD3IcM3nL0oyAQAmtZw6Z20f
 4bGa62x4TUGgEeKjZhcydFivwWmV4xapTaa3TJXBawJ50zR/zhtBL4tjb5cuUOypsoT2
 WbqTVoGkE+9xqxHA5rE8PqzIHom98spX9qzpiJlaCjzcMqdWUNeuSsnuBpwACx2Lss+3
 wNmmxWu/SLJ2NBKP8jUdGBjCYjW1YNDsh7J7mFegTfeEWqawEU+RVlfhs7wem6poeCTk
 DHivt6dQK0ZZE6FsfZP+rWQ2IiSk1i79cwRNVp7yPTtWXnQAvIhMbSc9Crcl4Hgw5RjU
 RHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362285; x=1714967085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FAB1/rbCC1p7W1eT4OXUmC8EUcIq+kxWaDPBAPzPEtg=;
 b=ipNFIXcPut6Ut2h4tN32XoUjU2XrvX2ImEepr1xlL5/GZwfXUcHfgNGNmJZe6PeaEF
 pL1EZGZZCEqw/5OQl8V2huYdYVX8HaN7QsyAdokwcbdtCEpc0oQoc/IHs9jilje2Wn9X
 OEqtjTTEAG2rkAKYrRDYY4CWFeHi+TLQytSiUG4dGnMGWkxeT2qp/QjEq9dGsVUXoIap
 lonBMyhvwnc8pTG5+oN+xl4SJmakJZ/JfQeoXNDAv/Y3GI82Zdcxx9LH4V1Mwb6mcczY
 kWCHbjPgXs8x4n+i8j0wQHAcBuq3HCll6FpZTHvFfxxL7FcOCU4wjQo1CcBiJloA6tzI
 nhBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwuxyngouYYlimloTtZ3y26f7iQlSlKxqO8aRVfTKSADF16qR8xaB/1CKFQEbtczWwh0FLC5cFKyplMoyh5/LwsXWproLO4C75kDhQRUzwipoZ1ayzC2k4beM=
X-Gm-Message-State: AOJu0Yxt5RoVOqpD5F9u7oJFHPsdcI+/YBOfRlrb01k3lIfWjK5lOUQH
 WFoW0H3DiVcYZMHo9p3eR6wnt288ffCRrEH55g+axc9QojQC7+h9RYtr3E4rSfY3G9XcpiVe2oO
 Q6WLFUY//7xBCEzAQP2Gz2kxMm7k=
X-Google-Smtp-Source: AGHT+IFDHHpNkUYVHEbzCK46Y3qC8MGeQmSMWl9lf8RWSedcNIYGw8Ra9rEHk4dcZqasYSwG8QGmwlYv+lfSItidy7c=
X-Received: by 2002:a05:6102:2d5:b0:47c:20f5:ebdb with SMTP id
 h21-20020a05610202d500b0047c20f5ebdbmr9174463vsh.9.1714362284434; Sun, 28 Apr
 2024 20:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-2-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-2-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:44:17 +1000
Message-ID: <CAKmqyKM9Q_xYmERTGhZjQRBCjUvjwdt6FKfcpxVOL2vC=Lgz7w@mail.gmail.com>
Subject: Re: [PATCH 04/12] tests/data/uefi-boot-images: Add RISC-V ISO image
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Mar 15, 2024 at 11:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> To test ACPI tables, edk2 needs to be booted with a disk image having
> EFI partition. This image is created using UefiTestToolsPkg.

Can we document exactly how this is generated?

Alistair

>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  .../bios-tables-test.riscv64.iso.qcow2          | Bin 0 -> 16896 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.riscv64.=
iso.qcow2
>
> diff --git a/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qco=
w2 b/tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2
> new file mode 100644
> index 0000000000000000000000000000000000000000..c720bf99a45fab6d1e21963cc=
a563ee0ea059b82
> GIT binary patch
> literal 16896
> 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
e
> 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
p
> z<c0L_6y_-DdUj0Z<$Ct(J8gf`XEp)2Y{fh04(%MA+b-2IbB%lNDoo)**V`GSDr9(0
> zeqE}!w6EUiG5aGJiq#}kJ9vrC=3D8R236mVoqP35-18DWagG)2<Xg1L{nbl>lp_HbQ$
> zDHCbT7LR?8UjFXo{AI%{?@<f)uWt~bWGW-}=3Dr%pUkemPD%NG6L50>JTl{a}&4~Nh}
> zi22saY}Y(Uj!pC}jUw<9uPx{KYrWX95We%xrZ$-IAkUZDOl>JOIxUj@G@tiq*JGc&
> zSvyy%R~)GAJwiNK!e?DrzeU(7-PT3FexP|8q<!wPYgFj4H3#ZFaFxw$Z@8n`jo{nQ
> zlXER3(8v)fC>^6*o=3DS>5wLM_?95b)f!AsV4)zq@GFa3gS@YI8x-Gz60UE#+@Y<2CE
> zZz_Uz7t6*DljLONqbIS^&X;KeqE)-(JKRs|4tU^*29rdG0|bB1S&cc~cc*?jy?|gN
> zQ@eS-LiUsbZT+7T=3DN*f76cJ2}rrcxhLaJs%=3D^{j<g*7&yAiU?#+cNkV&6{I66x}&V
> zn-zm2%$YWMRURvw$OQV!edbn)%nerhby^1#mm&?}6+ICtv@TY(T|)Wo-0QLX0hKO7
> z7G!SaN}yA<;k(OqO4B}m71yyF9^2K9^)cJn1!Q;y8Rn|LCO9)4u92T~k=3DL<xn2#^m
> zeRdU3c(<M6mOJqT*F`+d<l#hayT(R~d-GM??aZBcvAPO!l7V}wecW2@FtQ=3Dw+Zi$S
> zf-3ct{nwu-XTSNP|8SwX_LMQ%Eqm7y`+4J+gt%vtx?-S$d<07~JeEy$O~&%^*Mi6J
> z5dnGnupZjb11-EJ1~J=3DT>RZW_YaHuzsX)I#XxXL+YKhjYbN;s1tpP0G?P({a;ilV{
> zHVPfbRuVar^Yimp*u@d-TF!&@Txkby?qV!4X#}w)k_K^du!70!O@7Ap)bZxwd@O_%
> z%F1p+wNFJ@C4Bv7NVZD@z1JK9a?-<tz5Ab$47gK=3DPClG^WCg3<S@l>*8!UZMK(0Dy
> z%rQ@~-f$u%sqZZr+&y$Xv#FLGxp-5#c!Tb$W~dqnCTdErXpZUVq(9SB?v(r_M}t;e
> zI*5a3<lhJt&E6|bAf!=3Dg^+}#hs!s#DvpS^a;58G{(`+C%XFg#IOFG_KXyVp#yL00u
> zbIK-vEB#$Pz7-M9*DRFHEw8U9KmC}dC}Q9B3tkl3HC<n!x#Df7iS%15UklrW0rEa*
> za%GiUw8<l91N46FW8NK0PJX+5ffG6AVdvNu?{D1Lgp!<%KDKY&kIQ3<-;W4ohZ1-(
> zwVQp#9<%Wsa$B}+bP`YhAu4jHdayF4$+j(D^r|WZmoYAI#^$M>Q)l6pnm9l@w-6(@
> z>$|(kQE_iq_;1h)E8^Y<;+&>Q%kFj`uNRC>>^{fKw)uoPq{R%pL@xJdmFpZK&tmY2
> z-wAONN#kbb5XWTI8R~2AVk#9FQs?3NMUQ0@YL%G?`NGqjOG9D|yQpH(6^KAp@bG7_
> zg12^$mT?uH4>32&3?C0X9!%qZz)cE%WAn-128eF9NGOVn5fZbArjkc0PibM)RAy`R
> zOMjb7S1852lx>wt+u+HoIn+--s<ma`@SqA}{=3D)D%_1mC(>W)$*#om@%7{}zQT5OGe
> z!q8kax#wA+Wf7D;#BSK~!mv>_S`_Yu7NF`L%`4(%;Sg`bTD*?GRz$2$<u_FOL&zH~
> z&n66FF6UpN_qy9n@&phbrB(;4yP%1^7WVb$ue{uMy1Kr)(DM}p-q!apq^YSWb@Gz!
> zs#5dBZuV;rrv!6{S1eJIsaAX%$v%@7{wQepp=3DF`!EwRh9!!-J&BzTjF{??-*bSm-J
> zuj-Z*L{&-Ry{z`D`}l0lw=3Ds0pr4kD3a*T@L4r11t#Psy$s-gRbrukKh&)*SE-bVf;
> znWE)5B77UhOEB>1U4xyf9IaJ=3DoBWn<SqJX796~z|_>ZEqGDl86w8fYym%BB$DU5JZ
> zAKQk)AN#dbIA(kzLm$uIraCqf!30;9Cx1Pomw|Bc9wpRKW7`(#Gl=3D-rey)Br8eIbI
> zwy`pg8?a_S9vy<`eT7DP_iRebdsbM&-u%Kz`zS>iz)RG1$+iInp>cMjV2x9~xTYLU
> z5>z`RVZ+2_^!4QElIzGeO!lg8zM8kOLMy4c^&p6+j#nXfraAro6E$}!S>8|Wb5awm
> z77$UPkt#>C?Y=3DT#A?rc%*ko9YJ-NNqEK5zBng6D9m+r6_FDJymq2m_u?fLJNc3u`(
> zOcMzwp<chMtQv#9(b_IS-Fh{18}sM(5S`3jGBf>G#~%rOvCt{TPnRqT<6Nvt_2TzY
> z2vdh#X@8D+hP}&*ch?UT0Nf4<(@U|?-?1?n1$L|*qT9s`*ta7M`jV`)&|CxSw~@;z
> z*(*l%4-be2tdoI|u4vvGywe>U=3D?|!ThPq$9ECt<YE7{z@`*t6HccDIxLSQJ>yb!jG
> zj^^At{H)$vJSB4+nfXChJ)AI7zh^4nJ74H3AWl8rOz-TM&HFg(zUM1({?Mn$xgnXs
> z2)v_6c(#$j_QA5_$OZYW0@<x=3D+*O>zW>r_Wgfnbg=3DOrZ$_6Pe6Uw&-df(CrlGpf_1
> zlF_!x!UkP(2IVU$>x*>kMxMVX(8HARY^O+!6FG`rB8pInG^s~@91XfIlbgiCvKkN|
> zzV^1FE7UlQqA+xyG9rpci2#1G1)Jx)cBuKm$R4EtV7Mk1wz<WnHnR3oQ*8KSDoqC7
> zW@eZ_u`E7*w@14DpffgFakrf}B78B7b}>}@-xO@w!4w!DaARsqKh*`#&ADG+hCSqu
> zkaJ9~z9`&ILyyYeQ+YD8G(jE2C2*8}+4qu&Ksi8uL=3Dqm&2{yKn&4Oc&&8PNmP-n8P
> z(^^m)!x?#&f(g8;Ue-Fgy0v=3DmI9_%=3D-KS;4nuS7hL8P|4bv2b=3DNFOsBz%1#$;w4ym
> zyR3owvtDbdkqidl7oHdhyrygrC~ho--rOGY)S*7;wyI=3D#5prEvh8MD)-<2lO9+XOp
> z;VKiS^h-FA_VN`+{HvRCzt;sdZIf=3D_1i0RUj7QrCc4i49)!LAT0Nl%SPbio-*;;Bx
> zA!r55q82<*5ZBIh3VfDa#vE)fb9Ih^8`eQ^vWD;-9(Ib|Bstg|*;fb8sl?ehXJI6g
> z<Yx0WbSWRyGod(_SPWVWM5t6(<}y*z8r5$U^9N=3DUQKSWykLF~xKOdd7{@m92+U#p1
> z)r7@+3VKYU9xu|lbP|#8fp*Hl@QGwHajHg(rfKz(@}phSA~Ew&=3Dl1q@J!-b%wv4>9
> zib8qSYv<vSbsg~7^USuAK4q_}<f4t0io3v|MKD9d_nN4@4@y|khopHbzfqrKkBG~%
> zO33o4kWc|Zc4xJ)xROUCBJ|5&upe>}pZYO)UtQw0WIF`;j;!)?$Vuj4c8x?^zhWYc
> z#Bj(jEXw2vi<g{Z*~rgXyk6X(%u#DoMDEz`=3D0#8<is^-LV`U#^%amn+FpsEYpmCB4
> zLNT_AF-x^q$>{oouijknA6hQJcR5^-<F}@&@(PP2IW4M%%58cnc)BU<Im+dfjB|$=3D
> zzkKO%JCI(%{9*uC4a-*!r<nRhQK&<Y$@}Z!TmiB7qelS%#i-wl!Qbs!c!44;?iNf0
> zqUqW56dZF`Kb5~VJ{4AhPaIM~axVt!4!bQQ3nE<KF=3DjOsyb9%*3^P=3DDpmf=3DD(QDO}
> zoW11COnfFEYCo^;u`O8{x0Jc24(A(76M56$EYacmyALB+ZrV~V^wpi#CCUK&#d|`9
> zmq#k!df{AyuADE2;6U!j{cxp=3D7lTSXeIuG9+PveMW#w8UVX9b#;cf%p6jYozo!AGN
> zGt}cyfVRhq&hN-RwDCh7eLde=3DexTDenrO|E(V1vPe@Ug~&zlO1qNa)&<m!W~1Sgq&
> z$|8KE{ECbWtjs}#qD5H6iYj;VPWo39_?zR+-JOImwi!=3D`7$ayB&6EOk>w?eZi`wfe
> zhtASXU|NPxJ{VvEn05Y%l#??}*}1!GoWHvBqa<Uf4~ImXq7yU*KR(|SGx2$$=3DF{U}
> zHI5%t*J;=3D8sVY6_2gNdN!H>BOHs25jrJ!IN@DK2ZpM;Z<*^vXm-hi>;-eHvq9`3;b
> z_$bdXPyeK<GIwvpuu?JGD39_W7e+;Y8}KIUdd~D_{FCiNpT$q({<|(d>G15V&MZZr
> zyv`L(kpAMMO3rb3cKb9N+Y@0v0iH+I3Oq?BBLR16fS*^-w1ZNc84kubTug7GOQP7(
> z=3DIcwvU3l<@NX!y5?EOY+51+~R^spviT(I#8($;RhaUs6BdfV?pSDNIh>XxqK{<Moo
> z<@;i@qGioa^$-nwaerjds0uwnoHOFh#&Z_X0#>KPHRJSf-v~g@h=3DJ+?p!6S&CU$%!
> z*7WAbc$Kmtkwz`ElvJMXVu7Fl>oX}bwg;$WK$P(MI<eq}o<?!;lx-{zO!3g9qzrcK
> z-j`Eu$VVaw{ydz)g^Bakxs4?QXFF$gm3Ik~9h};68ud8*lG>SMKq8)GlDWoV_o{Bt
> zJ=3DMJx7oCcV)?brsj478=3DnHv6zvr>0e*Go6AY|AOk@v~F)5$%#_M`d(E;4rK-tTe!Z
> zZV|27%KPPY+%Ky`zhx|IO+YeXwgFWWRUy?&K5r9<nG56;a%u)NiGbLe&b8JB9szzn
> zmd98Jt&6Oa!lx3S>DuT9PMc2iPqR-ilwmkgIC1}c+Vi-5t-U&Iha>^T4fR5D-)+v#
> zJ<*-qoy&dkaByX@{VtkeR~roz69?4Q1!~XegmjigEfaLcfe96O1$eKQe|L1X4z>=3DW
> z2GN3h(SlIHY^XsbU^cWMTyQ>W&;xKjS`a4q4Qdbt_zhYR0eBNNh#rg$Aa5gfltDh1
> zIzlMzX5%JJgf7jC9q@<Te*$3#{6BvXBnJupGKtXJ78W?Ze_rU<{`T8qumL}%#&)*c
> zX1EzGG>TT-X&YXT*K*^u)n83hyMOI^(Ds#e*r>_#WWOViCs2V1hx*)jJkg1iMdi|D
> zCL-N(FsT+Y8f(F!eN$mMAEKgPvo~FBwFr}a9+f8Ix;_`Ycw6VPHWR7ucH3~VG#Y2c
> zWAxqQVtFi~&Fhe!-?lTK?<b3L@^MEMwbWp;fJ0lB-(DLrMLY8U_eTsN!Zg4D2rm^7
> z*?G*sHV6@VAaWE7Hpl_|9ojVC?}WrNKQeif-Ohsd1xfV+8{7u3bzkev*1faa=3D`I$(
> npx=3DG!ac+7rk>bW6>2rDhbE@r_>N;{0>t7xa_%HZ>v<Chg0ou+}
>
> literal 0
> HcmV?d00001
>
> --
> 2.40.1
>

