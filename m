Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECA4EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soONQ-0000ER-VT; Wed, 11 Sep 2024 10:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soON7-0007YX-EO
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soON3-00047N-Of
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MWvinVVNh5bzHESG2Go2I3vqMmFKIn5JdAQAKvb4He4=;
 b=B+GidpO9I3A/N9TW1NzvHZKeOsdycInjbxUOT7RjFSzb2hp1/tGKL+2NIo9Jdg4vuIsANx
 wIF44Wf56Cal5HJuVAnUEwp9Qwd7dn/3bz9R9sKf1kTKeqmjfLp2iYs/yFCR+sGYN2/hZy
 SD5Jg/uqOGZGug6U5/hNBhKYeX5D0aM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-8lxJOfJCO1iE-lkZMGJNCA-1; Wed, 11 Sep 2024 09:52:08 -0400
X-MC-Unique: 8lxJOfJCO1iE-lkZMGJNCA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5c40e867910so227840a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062727; x=1726667527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWvinVVNh5bzHESG2Go2I3vqMmFKIn5JdAQAKvb4He4=;
 b=Yx+qLSYD+/Iq6KLeb3ph24Ohuxj3TMk9+AtNXRX+omEYvGjjTiG8cby+9DtqrkdZ+g
 i6Z/EdQylJ0kg+AiHPGVYNbEk47AOwb3kPa+SXDue7ZquGsvI4Z2Cxk2YXsj4zvRLZnk
 r4ZSMvflnsBRvPfop9yJf99v6K5IuPpYnOAS0ZTKMEQzqOhAyONafGT42hPjyjh7Gav1
 Y9LOap2Gov6jM6eDuGhT3utRE2YkuZI1oql6Nn2p/sAno2w0CV7b+47q7CvdJ7Tn2Xx3
 8znmkiY0YEB9dZXGQwilKM4/HguJHmYnjdX/BeqPV38KsrhM3DCU/QYTYwH7We2emdRP
 MH+A==
X-Gm-Message-State: AOJu0YyauB9y2KeX2+S264l3bSMIrLrNbMmHF90kxonYau+cH/HsyKPT
 sAhprBA9dMRPDuAnBPFMQt46e8r8Gd0cYCnTZGZ8cKsnBkHQ7qGpoeGedLWNQ3HOWunnE9Y96r2
 1vucv1eosAfIy27gv23vTCwsLbg5weImwaeRNY7PeiRkNl9C78XzF7jedqfHG0a2Pahmnn3XhyM
 LT/NuPKXoBoC1fazOHUY50R3X0s6uLKQ==
X-Received: by 2002:a05:6402:34c3:b0:5c2:58fe:9304 with SMTP id
 4fb4d7f45d1cf-5c3dc77b0a4mr18389128a12.1.1726062726202; 
 Wed, 11 Sep 2024 06:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbF0tqpV83JVygqv7GTdJvqukQXRqCbIqG6bJ3IQnJGPxf1d8iuoEKKj54aizkOPuIHsfAqw==
X-Received: by 2002:a05:6402:34c3:b0:5c2:58fe:9304 with SMTP id
 4fb4d7f45d1cf-5c3dc77b0a4mr18389045a12.1.1726062725200; 
 Wed, 11 Sep 2024 06:52:05 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd467a7sm5368254a12.28.2024.09.11.06.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:52:04 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 12/18] tests/acpi: pc: update golden masters for DSDT
Message-ID: <a6896ebc8ff8dadef391f6fe4f8fd4d38bc7d538.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ricardo Ribalda <ribalda@chromium.org>

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-Id: <20240814115736.1580337-4-ribalda@chromium.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  15 ---------------
 tests/data/acpi/x86/pc/DSDT                 | Bin 6830 -> 8527 bytes
 tests/data/acpi/x86/pc/DSDT.acpierst        | Bin 6741 -> 8438 bytes
 tests/data/acpi/x86/pc/DSDT.acpihmat        | Bin 8155 -> 9852 bytes
 tests/data/acpi/x86/pc/DSDT.bridge          | Bin 13701 -> 15398 bytes
 tests/data/acpi/x86/pc/DSDT.cphp            | Bin 7294 -> 8991 bytes
 tests/data/acpi/x86/pc/DSDT.dimmpxm         | Bin 8484 -> 10181 bytes
 tests/data/acpi/x86/pc/DSDT.hpbridge        | Bin 6781 -> 8478 bytes
 tests/data/acpi/x86/pc/DSDT.hpbrroot        | Bin 3337 -> 5034 bytes
 tests/data/acpi/x86/pc/DSDT.ipmikcs         | Bin 6902 -> 8599 bytes
 tests/data/acpi/x86/pc/DSDT.memhp           | Bin 8189 -> 9886 bytes
 tests/data/acpi/x86/pc/DSDT.nohpet          | Bin 6688 -> 8385 bytes
 tests/data/acpi/x86/pc/DSDT.numamem         | Bin 6836 -> 8533 bytes
 tests/data/acpi/x86/pc/DSDT.roothp          | Bin 10623 -> 12320 bytes
 tests/data/acpi/x86/q35/DSDT.cxl            | Bin 9714 -> 13148 bytes
 tests/data/acpi/x86/q35/DSDT.viot           | Bin 9464 -> 14615 bytes
 16 files changed, 15 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index f81f4e2469..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,16 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/x86/pc/DSDT",
-"tests/data/acpi/x86/pc/DSDT.acpierst",
-"tests/data/acpi/x86/pc/DSDT.acpihmat",
-"tests/data/acpi/x86/pc/DSDT.bridge",
-"tests/data/acpi/x86/pc/DSDT.cphp",
-"tests/data/acpi/x86/pc/DSDT.dimmpxm",
-"tests/data/acpi/x86/pc/DSDT.hpbridge",
-"tests/data/acpi/x86/pc/DSDT.hpbrroot",
-"tests/data/acpi/x86/pc/DSDT.ipmikcs",
-"tests/data/acpi/x86/pc/DSDT.memhp",
-"tests/data/acpi/x86/pc/DSDT.nohpet",
-"tests/data/acpi/x86/pc/DSDT.numamem",
-"tests/data/acpi/x86/pc/DSDT.roothp",
-"tests/data/acpi/x86/q35/DSDT.cxl",
-"tests/data/acpi/x86/q35/DSDT.viot",
diff --git a/tests/data/acpi/x86/pc/DSDT b/tests/data/acpi/x86/pc/DSDT
index c93ad6b7f83a168a1833d7dba1112dd2ab8a431f..92225236e717b2e522a2ee00492fb0ded418dc7b 100644
GIT binary patch
delta 1914
zcmY+_OODep0DxgPNnd%jP12_CiUT0A;Q&p;V$`UN=xkV3oPpV!ldxiqgg66h&cP{+
zY{yalUETPX{l!W9^Znl{tnc;9$2UR@KK}~edh+S}<6b@H&Fk~!>0R;R_3`}aMf}K{
zui>{W3L>RMbGz2UejYTp>se&6{yy}Y+qH57zqws6B1?i;se#bVy&LJO5?N}mneO6-
zQkb-ECwnHXx{*%ZT+gO;n|ii9w{v|{x-IyobW?p>p4-y5rCCMBN(Cl$TL?_*<_0!(
z+YfB&mKmDTZD9!MkkTQcqZTUdEgL~PqI5**7}7DMV@k(8X{^))(1|W(C!J6_p>zuA
z6w)cBQ%b{DYM~*Zp^)Zra0eAq8bKOC8c`Zi8bcbJ(j95shf1Z#{iip9G=VgsG@&$w
zG=(&^rGusp+MfRm(ix;PN@tYLA)P}y?@N^)_Mr=1n)5er?E=yTr3*?kNHa(?N;4<5
ztK@*@Lh3i%-IbiuoYDf)0@8xgg3_fa-D|q+L#0|$x}<ak=?c;nr7KEHNJ~>XXxTxf
z`Bf|_T|>HtbWQ1+(ha1WzEo`p-I!A9J(=_0Lb`=?OX-%<9i%%*cb(KgcZBYRZ2w-&
v7WR<tDcw_gfb;<AfzpF59rW0Teo;qAkCYxMJwbYc^hD{&Nq_(I{*?a#$3o0}

delta 204
zcmX}gy$XU*7zW_ipT$oCl^|$t4T9<dQis9_Nq0S-a{-5-p(JvY)<e5Rvk+ZFbC*=K
zI6lwEZ|4*yVcHG>&3@8YKQCul;%81oaj=^7L(1Z93hC)pF2U};b!Ak^BO@J!EO)E`
z8Q_hhIHYHpz<Lvf5Y0$&t#K72v+D%n*6Xx@Xk5if@5cYnRB<x83Lxa^P>=)r`$a7P
VSu!$E3k_1#Im4bk^4G<B4}P3QG;{y}

diff --git a/tests/data/acpi/x86/pc/DSDT.acpierst b/tests/data/acpi/x86/pc/DSDT.acpierst
index f643fa2d034053fa07f74f095565b64f021d4290..25b39955059409b177870800949eaf937cd39005 100644
GIT binary patch
delta 1914
zcmY+_O^%x|7=U31$R7}r015d|FHotAULXlwjDn(3GyACf?mBz-BwbX!K-IJK5WT=`
zUGW(s-d!C0%6>2;e?PvR!t!3eyuDMZ_w#r7-qTM%9{2NOR=qx7o<8KCULVh&U(~Ox
z`WAjqqaZRyRkv%Y?B`x}yPi}U*WZU;b-SM3z^`uCi%KU!Y)ntp&AlDf)mf#9y(Zno
z4YiWAY$kh>p4(BKy1AZB%O>?~d1~hRQo1epQo5<WEl*A9+fr81u`z+9ZVQ2=Zf;;x
zxBbATZkfK6ZVP=#`;_(x9W+pFZ`lCS0i^><hmZ~-9a1{%NMmD0fR5@?x6%=%BTC1R
zjv*aWI;J#iq!t<i8Y(T1gFC2@(g@NB(umTC(iqZMN_V7j7phG??moQ}NGFg^D4kH6
zK$<|B*wR502W`%O3h5NmDWy|NXOPYyopq(A9(JMgx|H*mw{{NcoYFa^DWoZ+DW$2C
z+Ep?@Go|Y{+})Lo(u~p^(j3y9(wx$Tl<qZMbfMZTC|yvxgmek%lF}um1*C<P4qCKO
zEx(Edr7K8Rkgh0QQM!h7-Iba(p=&91y(c;U4Wt`LH<WHD-9oyBblXY=x+Qd{bo2Kj
vTi8LmqjX2<9@0IedrJ4VbkIW=`o$a|Jy3d}^a$w@(j%ouC;ju!`&#@5@EFZr

delta 204
zcmX}gy$XU*7zW_ipT#c%l^|$t4T8J@e}=*cNt^X}&e(7W8cHHZX+5-CbOX_~bStez
zi{tZr{I^F@8fBXiprucm=;yhYr$KJVl!S}vAfh~3XOOO57ZU6qSXV~1JTlTz%4)|-
zkOAJ>ibJ}V2`pD}1ksKa*IGw0GP_P8Zv9R^MC&L{dN;v;W{Q*1RR|$ZhmvgczF#x~
WkQE~XjnE)PQ!wn=qj+7c?eGW5el%79

diff --git a/tests/data/acpi/x86/pc/DSDT.acpihmat b/tests/data/acpi/x86/pc/DSDT.acpihmat
index 9d3695ff289036856886a093733926667a32a058..73a9ce59e9426b180fea0ec5820c4841ebdb6700 100644
GIT binary patch
delta 1914
zcmY+_OODzw0DxhWgjZfb62dFMuDeRTK?S6X5fK`d*`uDJv#jKvq^n+_>T!C4Zo3}I
zmF+mnzr)18>@QB>&&RhWtnc;9w|7De%3tAoPd@#4+|Q4B^ZI;w`cQm&eLR1D5kK?h
zYxq5jf=DUR+^)5-p9jtDdJ<WzzYo3Uc0Id+-`uVjktIQ_)IjLw-i>s17FlYqneO6-
zQkb-ECwnG6cO#v;xt>kyHuY?IYUlc<bX)LE>8AR&Jhi27OS6iMl?qJiwh)-q%?)ho
zwjbEkEi*Kw+rkjiA*Dk?M=ey^TQ-7pMCpjqF{EQi$CQqH(paeppc7rnPCB7<Lg^IJ
zDWp?Mr<8`R)Ivi*Lm|!M;0`LJG=emOG@>-3G=?-br90BN50y%f`%iBIX##0NX+miV
zX$om-O9xFIv_1bBq%%lol+GxfLpq0a-j^yp>_Zp2H0N*L+6ANwN*9!7kY<o(lx9w9
zSIGg*h174jyDK@RIi&@p1*8R~1*J<<y4Q5shf1}ibV+FmX$fgbX-Vk{(v>M4bk#wn
z`Bhv|x`uQO>6+3tr5i{$eW}_Ix-q5Hdot(0g>(z)meMVyJ4kns?mDS~?g*`fZ2w-&
u7Ai<9N-IkDknSPfQ@XdMgC6?OFX{m4fzkt|M@Wy59w|LK>F>YZzv@4Lfz1m5

delta 204
zcmX}gy$XU*7zW_ipT#c%mByf@H3({t)S*x!(p`_|T)-h{D2W`U_0Vq74MaE5J#-h%
zfzjglJm2U&qaY5F_W;md4;tyG#Wan*)DCIwFUP%r()A{RboDZmU^maYFe>GNk&avz
zTb6?i@Y+@!(zQ$=T7>~bJycw)9mU9OJBGM+Tg@SAM{&~I@%}SWoQ$@72zlJ+WTVqG
Ys01JjMg}UOL5eD4*s*)|JX@ds52i3S0{{R3

diff --git a/tests/data/acpi/x86/pc/DSDT.bridge b/tests/data/acpi/x86/pc/DSDT.bridge
index 840b45f354ac14c858d0af8fbd31e97949a65d4b..4cef454e379e1009141694e0f4036a2a701c80d7 100644
GIT binary patch
delta 1914
zcmY+_xsKC79DwnO?OZ-`*v@@*bStf>X_A;?6)Rei?IS7*O17XI8r}j?A$r79@f3sn
zACKj)%f$0(=I61K@1K8v4U1dx^5&gVolk$l2Two!yx&guN%{JGetOK`zuuoeyr^GU
z`6c|8MnPnZDzBG9+0UKwdO4~zuD%bw@_ISBfnQ!PXO$*FY)nU0&8-<#)k&ozdri8t
z8)_wKQBU?HJvE~$b#pzN7Io^`@>tLHrF2{HrF2t$TORAux23G2V`BnI-4+5#-Q2*Y
zZu@~v-7;M%-4?o#b}8)=+N+`3-m)H~JxY6&_95*<+NZSNlE%gi03B4NZlnWB2b2yW
z9YQ*!bVzAfOD!}6G*nt12X{~*r4ghNq!FbNr7@(jl<r95HdLEx+<tl!NE1jCN)t*)
zkd7c7+0sEr4qBi87}7DMV@k)AP9U8?I%!KyHEcttRVn8$Z|xM)DWy|NQ%F-tQ%X}O
zwX0-+W=dCYxVtMEr5U9;q&cKHr8%WDDcx&2YeTh}Q97e^4(S}yIi+(-7mzNbbkIcu
z)$*&jpmYi864E85OG;OeuG&(wB6KCCuJ$D7zlL-T>6+3tr5i{$kZu~OKsSVLm9GC@
wWD8qJx0G%v-9fs8bVupVmJYgaLqD25q<c#DlpY{GKzg9`;G}>5c|YF%2Z)!<hyVZp

delta 204
zcmX}gJqv<B90%Z^XN&&`ELz%IgXrZ0qz*+9k?wllZ7oL-R1&oa(t5NtToLWj2Q*q7
zpXa^LHxz_Hl#c<c^PwI)Pe*a+#qOL|{;b~)C|<22s1~~<3jFCgH%=FI<iwDwY|B%S
z4Pjg@pju81SS;rOr0Hs5nWpAct2%^yG%8IXO;ZbE)p-9IYC(2YKBPJwQgTr*OB51N
V87CWsw4h{>aP0Ui`Cgs-;0LeYG=KmA

diff --git a/tests/data/acpi/x86/pc/DSDT.cphp b/tests/data/acpi/x86/pc/DSDT.cphp
index dbc0141b2bbc77a6d806ff046dc137992c59a899..1dc928333d7ae7e4df6bb51d850af5e1cb480158 100644
GIT binary patch
delta 1914
zcmY+_yROqP0DxgPNpHEeP0~wx%fO7p$l5j_9W|<s=-DftfwP;JV1<PjK+HT4FM*Nm
zILg1(jepr+oV5Sm|M(cz_xh!JBgEj(ukfuWpT0lt=f}KxeZD-sD?YqFo<F^apLz2o
z{F+5Uq?BlG*IL-mgXVTUi7eLNhhB5Lp54H2Zr6**k|0)UAarx@M!GtSEVb86cX2~0
zOj@^-J(Hfhkxt!Q&!%;odbT{ZbA3~~E%>H%Q+->W+S0eBSw+T51txV{2u$kc1~zru
z4{Yj|8Jf~<VF>Av(jlRv7Aoy68$mjvbVTVG(lMlCO2<8EtkeY1i7sU)olrWVbPDMd
z(kZ1=O2bxap&_85kmhl42NhBpK^j3CQ5sPiLmHdX9ckQ$N~OpBr#FE#fi$5sp)`dw
zg*3ILgQgDJp8pKe8Kg5xXOzw%okKeBOO+n>p$lD_^EYqp0@4Mg3raIcGe|Q^GbgpH
z<bdWv>Nniom7LO?(gM-~(t^^0(xoZgYr5=1rCL(Dq;v)83epv&D@xapu1)En>kcZ-
zui~204Wt`LH<WHDEg>!YQdJUKno{aLne*R5x`lL0>6X$Rq&rA=ozy^ggzklG|6a@%
t_K@x=-BWsi^Z@CB(t|A>^w@`fR!2yWlpZOqAgv&+D6O3I_h0W@`5$`N%&PzZ

delta 204
zcmX}gJqv<B90%Z^+TuR~i<Y3VH3({GO^+yykaXAcZtn;hN_rWk^>EIjFA#mdj26e|
zxzE2-Vj+vpeZbhhX=q*+lQ?u^$EUzsj=GHEU=u-g%xj{+pRQeSx~d~56RFB}JOx=0
zrK1H@$8G?twa*~Sffh#D)|?u3hmem}tr=w5)`HA>-2aTVAgeA9Qk@PdIcQcDatWx6
UlZ9LwP%=+A_WYH6Zg$c80pWTyqW}N^

diff --git a/tests/data/acpi/x86/pc/DSDT.dimmpxm b/tests/data/acpi/x86/pc/DSDT.dimmpxm
index 1294f655d418dbdccc095e0d47ab220869a61a07..9f71d2e58b1707e733584e38dab7f73f9bda5eb7 100644
GIT binary patch
delta 1914
zcmY+_OODzw0DxhWgjZfb65bG&T~+G7D?+*$5z$eZJ?a@cdw1JQbTt>KdWJbnPvOdT
z9Od6(;$QX`C-7Fie+}z<{qp`nh{3Nv;YUwC{eIl5$GmxczC3*@zPvu3zrBdJy!jFS
z%%UJtN;J1?E$rt(bGx2J7VGaruen_-H}IR=^&+w)h?N=$-Q2s8t}2nG_L}J~ZYYIG
z>vpnd(yANj)Xnv5TDPfZ%X2%|H>KNxZ%Q}Sx8=DleOsDUWUN$RQn!V`q;76tQ@8!V
zrf!*`Dcu%^kPayw5;|(3(%!NWq$5g4l#U@CLpr8(+>^#iO#q$fQg+e_r4vf0kWL|;
zQaYtHY^4?&0vZZw9tU?&A*B(d5u_2N5v4Jtu_@h=#(k(%dfb0{6G#(C6G{_GQ%F-t
zQ(HP{>Y(lU&mf&aI-_((=^WBIr1QR1>0uwb(4{$l^VTjPT~NB9G=nsQG@~?gQoBkH
zXfC9F!`)rUDa|P@AT1y*C@m;mn$o?d%RW@9C8bMBSCFnCT~WHCbPeg+ln%P?pwj#*
zt|{F>x`A{<>4wrRq}#q!Z3*3)QtCaK^WQ<bgLFsfj?z7(dr0@4)Ij%y9)xWFUd$E_
skRB*KP<n*)2<eg1qb(h@>_fk+64H{=lF}2TCrD3}o}BdWKksw-AM!HHs{jB1

delta 204
zcmX}gy$XU*7zW_ipT#c%mF6I54T73#N*xNLB;ECR&IKHThLXrpS`Y0O-avE>U6;|~
z_&ncz<53U?$#?{4i#JX5+j^eHUTTLF`J3q=pfoxpkgi^4671z!4@RZDFw&9B;>dE4
z0bbjRL%Nm;Y<FP*QI8eZYDY0LyN)5A{Z1>0+EJYJZoL1@6epuAA3|QwIoas7Eh+)X
Vf{}qrXpo}H7*4FoK6h(5`~hC_Got_i

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbridge b/tests/data/acpi/x86/pc/DSDT.hpbridge
index 8012b5eb3155377dc7995b73059ecb267d19232c..db420593a3c51eced25cd57420353fbb9ccdf63c 100644
GIT binary patch
delta 1914
zcmY+_OODzw0DxhWgjZfb5(sb9161mw7a*jI5fK`d*`uDJvv)7hUDvbf1*)E^hp0TV
z9Y^_hnE03d#R>fX{8okay?!}<5MuE2Px#T3Pj8QV^_VxW&zGl9#h2H|^Vb*gJ8!;+
zKe8x@loHMDS_}Jm(A=(Pk;VG^&}(kj$_@PHcD;x!31X!NLO1trq^n9~sl8^piyKN|
z(z>1OnY8LgI(2hBo7QdW+49`Z^-bxv;G5D-^=)}>OW&4e6&WiPnAB|{FsYjx*wk%5
zu&G;SXiB$*A*4e}hlGw=sI<3i1nG#<5v5~D$B>RG9rvWMQWHQYx|E%CLg|FkDWp?K
zr<6`94O^*&hJc1bn#aK%R7hzAX#{CRX+&uZX>3Y&q;VfAl^*w>-UQMF(uC54(iGAZ
z($tm?nmTBE{xe8tkj^NbQ96fo4(YrvReIQmE_7+m-@LU8NEehYD9s?vAk8SvoYbz8
z1DXq|-*9(Va!PYb3rGt{3rY)0m!@>D>9P-%YDwvm(iNmDNLQ4uC@mo^P3fRz2bJbm
zv7~ej=^D~CrE5wzkZ$@?wIOt4N~!l`&VLK(7Sb)HTS|A3?jYTDQUl!)x)-wjdof$s
tL%OGQPw4^D1EdE^54LpBV;}lW9U(nZdZhFO=?T&kr6(u-`_KDTz5}&$%xeGu

delta 204
zcmX}gy$XU*7zW_ipT#c%l^|$t4T9VwbtsIGbl2lK7jOs~N+d^VJ++2KHxON46fKU=
zbMrqQg-MuJBS4$KXriB%UY7Wo9Z?*trh|~Oc$-4HdYwzKhi_dO)$+(lM<L4{D?kQ#
zYby@vS|+gGL?J{wR$OZx#mMYBfw=cOEg)J)anif-|1(pZjIII*Sse<p(ffYU2tbyM
T3^YQ66iv>sXV3h7wl2dTv#B&=

diff --git a/tests/data/acpi/x86/pc/DSDT.hpbrroot b/tests/data/acpi/x86/pc/DSDT.hpbrroot
index 4fa0c6fe720f7859f0541b82f828c0329a3c0548..31b6adb4eb941e5bf0c02ec8c3819c9213adf022 100644
GIT binary patch
delta 1913
zcmY+_yN=pG7(n3xo11TdZEogPrp+q=PO-v5tFS%F1Ek8f(WFh8K1!8p+q_WTWLEyi
zWBGIpo}-!1W5dtl?L$!B%a^xIsowWr!GHbq=W#zjX4UKS<>_Po>Gkpa`9=NBs&B!M
zH1tDbRCT+S%6{%ux9drzQT=_;uWr|~8+g_2dQoZYN5=G2-Q3$zU7b~$*lW^V+)yh?
z%Vu(4(sMhiQ#ZG7)3QnXwmda+Jt^H5JSp8&&z7gA^lT}s=*SpfQnv+PQa9JPsoTD9
zQ@6}OO1FgpqytI^gbo|1wzq5u>5$SPr6Wj3kd7!Fb)=CoV?f7ssaxro(lMnINGFg^
zD4kFmG*Sx<01cFu$H5&`KxqhR2x&-ZNNEIVB&9pjs0-Dm9(SMK7}6Nhn9`Wi1kwc3
z#Fh@4IB0YJQ%I+fPAQ#II)iiu>8vX?^{@+_*QK1lytQ*k=akMVO(9JoO({*C)UJ{N
znkiks;qI<vlxCFXkmiu)l;)H!q;#+8q6^h#LFt0hC8SG8my|9kT|v5%(m_`(RLig8
ziqbWtYe?6Wt|{F>y6H;IhR}_ay55tVe*tL$X+dd0=@!y0q}x_1&@G`mrJKJO*}@Le
r9i=-;_mJ)(-BY@^rGp;2&@biy>4DM%rAJ7QkRB;LI_baPy|3XrepAd$

delta 203
zcmX}gF$;n~7zW^1ZOBgom8RyPErMDbGKZpwNOwK&*5C*lN+L%a<7mI4skJ}UKPg&n
ze4bbD(xEtsQ?~_J{VRRWvr(2rnZKa*bUtXul&v=@WN25p1bam8jZr0!jBFIL+_3`W
zfNNiI$k1&7%he)=&|SqX9VkW((+R}AWi)}%f#PJFiT*QGoE%eA2zfdb<iq=ZQ42tp
Uj2zU$f)sVmuxHQwJ#KEjA1t^tL;wH)

diff --git a/tests/data/acpi/x86/pc/DSDT.ipmikcs b/tests/data/acpi/x86/pc/DSDT.ipmikcs
index 0a891baf458abee4a772ffba7a31914ec22418ec..c2a0330d97d495298889b9e28bde2f90235cea88 100644
GIT binary patch
delta 1914
zcmY+_OODzw9Ds3?gjZfb5+J<Q161m!2LRH=hzO0!>`~9q*}J!xU01z8)wA>vy+F4f
z#m*n)+hO8Q_AgH0|L3=JSlz0Zw+~A7{{9X>div?-{dT%f>(}S=)2HIg>;3ubi~5z<
z-@_kS6hy|T`g*C9``oLqm!rz!=KIjAua}by{Q7!1t1Jm(V|uD-ZjVt@om7^(YqmSf
zP%E2O?PSlUr^l#CWv=Jas!cst9^1LTEoBS7EoG|j%41vluC%M@*qFekvW38=GB<Fk
zY(H?REYr88Y@rWnpVB^|gBGgYEgL{Opmad#5Yi!}LrRAoX>800&{0$Bhjc{gh|)2n
zV@Su8jwuaWse^`qhDzJVK@KXUG=emOG@>-3G=?;`r5tJ8g=*7`yH9TdX##0NX+miV
zX$ooTN`a;VZO?xK=>*aVr4vf0kWL|;cBQ5ncA>MTwC8W%+8LxXN@tX2kY<o(lx8Az
ztK@*@N;hw~+?AZtoYDf)0@8xgg3`Gy<u#pmq1wzTom0AibOGst(gmeUNSC%0=<)&8
z_E&L9X$ffwX-R2G=?c<SS87&-u578BJ=ybLL%N1^P3fA_4Wt`LHxH?WZV25f-TuAU
uEo>p(Qo5yd2k8#d9i=;03UuFvelvSW_mu7_JwSSZ^g!uBq<{W-N%;=-%*>hq

delta 204
zcmX}gy$XU*7zW_ipT#c(m4;|;4T9<dQis9_Nq0S-a{-5-p(JukS`X1`(G5iR)@rmk
zKF>Y)&M8d7^g9H!%bUjfc{$4xKXW3AgVm%TQWkGhNKdbF3HJ1@8>31d8R;lwxnl*$
z0B;<{AwA0k)|)7VXhw=_jjI@$T_+F^yVC-qaTO=M8~;C3#mVR@fRLv{K@NIti&_A(
UWMrTg8l<RmhCO@bpQ~jLemcN3k^lez

diff --git a/tests/data/acpi/x86/pc/DSDT.memhp b/tests/data/acpi/x86/pc/DSDT.memhp
index 9b442a64cf711b33d80691fe84f1d3a6256f943b..c15a9fae947bb3929a30c60b7c0f2092705868f8 100644
GIT binary patch
delta 1914
zcmY+_OODzw0DxhWgjZfb65a%M-Bs!hDj;2qlA=+WJ?a@cd-o))dV#8^>LDsuw&N)O
z4io>fzc_(^pPygD>R!D)KL|0Xe}^AE`SN_+FOPZi{(61+RD5}VyncHVzw+is_%n-w
zNGZ|W>PpzpgXUJBMHcJtL$A5j7dP;mTYVK-62wXkgl_KLNLLq;rS_WXu5KuWNvn3U
zXVObI(y5#4*|cg?&z9$Qu5U`W1>clzs&C74Tl%&%tH@ZXz@%;qfl1xmz@~2dflb{q
zLsPmf3?Us-IwW+|LZ!WBBS=S-jwl^NI)-#i>9{A2m6`xL(WUI96G|tPP9dE_I;C_<
zY1m3FGz2sh(mW3Cph8L`NFzuiN+U{RNMlpFBaQn|sr0!2^d^udkS3HSl%|lTkfyeD
z(9}WO^PfRFgLFpejM6!zb4cfXsnWwfbfHUg{^qS+K)RrGL1_kQ25ClV=A?F&9MD`y
z{f4`{l2e*fT0mMrT2NY0x-_MGO_zPBR7*;il&&CMLAs)JMd=#SwJ9BR-9e@KRa{fL
zfpi1uhSCkCTS&KksoD~{HKo*hGUva8bO-5<(jBFHNcWKLJE?*02|Wne{=Jwj93VYV
pdZ4s~w1l*zw6vvz9{bSm>ImtP(j%oONKcTSC_OpppTAyF{s&CX%t`<N

delta 204
zcmX}gy$XU*7zW_ipT#c%71wBK4T9PubttTmbl2lK7jOs~N+L&TJ+y{JHxON)6fKU=
zbKkUc3X?Exhk(|;X{=wCvn=s5JEAyPO}vn@c$Y%DdX-DCr*GXDRr170M<L5SD?kQ#
zV=E5nS|+gGMj=EqQe0~s#mMYBfq3*gEg%|4anif-|1(vbjIII*c|I0oqxb!y7Jw`n
T8K{K@De9czz+U<1YI%bnwrDj%

diff --git a/tests/data/acpi/x86/pc/DSDT.nohpet b/tests/data/acpi/x86/pc/DSDT.nohpet
index 1754c6878839fc657230e1e714cd7c5142e0a77e..dd29f5cb620e5164601e303e37524530ddb12684 100644
GIT binary patch
delta 1914
zcmY+_OODzw9Ds3?gjXIsl0bM<sq0EzRO%W?7b7AxDzisDLuc=vr0Sv<sCt4qPEX+~
zcK%Vm9VY%{|KbFGeR?~E<-L4)d#6<I{h#oIr=Na4?&rs>dVRh;eayeSKAyk6sNY%j
zJ^YbIL1c`oZr4(|&%Nq)J*hOVzYo3Yc0J3$uWr|iN|PWqrl;!W-j3?(tkQ|QX1j|F
zwX$j1O!jPgZbx-0b3K=qP3pPw)Xep5DO>PuDN}t{o|@8krCmkG#soH%Ed(}|xq(Y%
z`+-YknZ7M$3w=oYl=cZ7G*Ins*#Oc3r2|TbkPaaoQabENV`D~uj_Ojk(h;R2O2?3n
zAstgXrZjA%4jKX)Ds3MJIjE4*2+|1Bh|-AC7}D65a-?w=s!cuaKD`N~38V?738fQA
zCy-8DDbR^PoAaMSI)!vf>6FqLq%%loU8$*uUFf_n?fKicb`I&B(mACmq$#8+rKw2W
zDjA@e()AlIcO|1Vqcn#!hcu@&r*vUUc}*8xs5T2q7nCj`T|&B~bV+FeX<<u&7A;iU
zU&Vsb6{IUjSCp<OT|>I=O3j+kwJmkMCwu-INH>sfDBV!Hg>(z)wv}4wme8Hj&EJdN
u!Vc0Mr8`RZknSPfQ@VGhKo4E$H*<jWK<R<fBcw-2kCYxo`uCsrx%dyBBg_i`

delta 204
zcmX}gF$%&k7zWU<X_x*Yv_%k{99#v#g0r=QqKMe;ZJHb)2o5TuV{r}cQM`b70`K5`
z6qk(ey~ie|G)wbt2XH=5>a)`{F0!Nu=Cqp32CbBe)jEfY*tt~T_r$+)I;%Y=hDsea
zyaKrpCeQ*Z@;zX&oTrecr-fre&B?Q!LEf5HV@MNfLCj9_pP?4y+L}PB<F29rjqew=
X1k{0(i&{ERvMxEc{87Fx{;2%}tYtI<

diff --git a/tests/data/acpi/x86/pc/DSDT.numamem b/tests/data/acpi/x86/pc/DSDT.numamem
index 9fc731d3d2bcde5e2612a8ccd81e12098134afe9..8a6b56fe7da18bf42c339d13b863aabf81780527 100644
GIT binary patch
delta 1914
zcmY+_OODzw0DxhWgjZfb5(sb9161m!2Oy-25fK`d=^FJ6oxOXKu6lv0y+zkO#GJyF
z?KsN6!^FSrFHYdk$A48=-|Lqz?}Qlmzry#PeERXYSC4t~`h0o%P<(oQJb!)>KlA2W
z_&tk)NGZ|WuC=hA2hHtz7Fn#n554Agt=zzGZr6**k|0)UAarx@M!Kp*mfCBkySSkg
zCav4ao=K~2q*FK7vuWL?o-NPqT;G&#3%)7cRNt28w)AajR*|t%fl1vK0+YJAflb}^
z1Dm>KhNg5|7(zOvbV%r^g-UzNMv#su9Z@=lbPVa3(s553D>VUhqD$FHCzMVookBW=
zbV})z(y*0UXb5O1q<I|NL4}k?kVcS3ltz@skjAETM;iB`Qt5I3=}jO_AWbMuC`}<v
zAx&-Rps9nl=RbpV2I-8_8KrYb=aA0(Ql*D|=t7s~{LNdtfOJ9Wg3=7q4AP9!%t`Gk
zIiR_a`VDt?C8so}w1BjLw4k)0bZJWWnlAfLsg{&3DP2Ljf^<dciqaC&(v%Kbc2H@4
z6-!Fjkgg$JQ@W;f1L>wORU1M#rj&Y5=KQyiZXw-Lx}|gn=?>CeCpFL=p?e|QzZbKG
tJ*0a|_mmzWJwSS(^k7Q|J@%nr)e+JorAJCnke(ntQF?OH-*4XE@;}cy%sv1B

delta 204
zcmX}gy$XU*7zW_ipT#c%l^|$t4T9<dQisBbNOwJ+a{-5-p(JvY)<e5RHxSuXG<Q8l
zi{tZry?RDL6vXua(B4lP>F32XiM+%PY2z=)y?~O<HimTdB9&lw&$==y<dKn%Oy)b5
zfei4<Rvgl`OklMR1Bhy<xK=rek=b?xaqG64LsX99q_^Y!XQDV6ZTS%LbjZj?r)f|M
WK<11LltP0PWy-K;kMwo1KK&mkqBS-E

diff --git a/tests/data/acpi/x86/pc/DSDT.roothp b/tests/data/acpi/x86/pc/DSDT.roothp
index e654c83ebe40c413b204c711adcefe3f04655e8c..a16b0d9d4becec47fa3cf57ed0077ff6cff88908 100644
GIT binary patch
delta 1914
zcmY+_J8s)B9Ds3Jl3#k+mgM)VQ?~-Sf^B68EEqwY-RT*cojpazqC+oG^h_Oc3Kk;u
zH}q|$#Si39lx*|z>n$v=<?E*hr8@uqgkL=U^z(K--p1AY^XciKcznM-zr3p7dG#&)
zo<%`qjH)i@Qn}Ba>T*7)EUv!~z3Os4%D}HK=ab5kAU39>>gIYM)zwjDsk>&olMJ=8
zY1vHnY<j$p>Qv@>E-jnXbLF9#>)TSc;M-EB`mQ`QrSD3+ijIv5Y${s_Y$|gDm&*17
zm&!6-Tgn!?kaj8U654B^+TF4qq&-S|l=dO*L)xdb-;&103;-R}rM^oClny8zLOO(W
zNa>K$u#q}w2xzFZeH`SVLP{e@BS<4kBT8dPV_V9R#%-uJ^|<}?CXgnOCX^<WrjVwP
zrmhrdD$wTqN05#n9Z@=>bPVYj(s5gA>R}r?sY`qQ_N|>jI-ztzX$ENqX+~)#QnyMD
zXs&eqhRa>aDa|P@AT1y*C@m<R+EQNAX&b7|l+r1sGe~EU&M2KxI)`*_OM%YsP;Gw|
z=aeoWT|l~^bV2D7(q&s}mV_>Csp~!2^It)_f^<dciqbWtYe?63sfDfy-6-Asz1S^m
tAl*>9p>zxB7Sb)HTUQEn*M@#IJ4knw?kL?ux`%X6>0YFNKfE8G{{x?A%_RT;

delta 204
zcmX}gO$vfQ7zW_ipN(GxDjgw$7C}%KNL>_0NV?Z?<^V&`q9k-FZHH<*MHh$;XtZ(p
zJi6%i6s1vCPXXicp_y5)mw6iGZcItInU5mMlYIv1n@u6XUV(FC)W|a<6Q!&UtOQx$
z+EpCVcWhw0iz5g<R@~5@Vr2K7LOh4PRuI}#oXmcL|11<ItFI73UQQ*s7<3(40mzDx
Tg;p4lqAeJX>|K1X&VBL&G=nuA

diff --git a/tests/data/acpi/x86/q35/DSDT.cxl b/tests/data/acpi/x86/q35/DSDT.cxl
index afcdc0d0ba8e41bb70ac20a78dcc8562ca0cb74b..f561750cab8b061c123c041fe2209d74c7a740f1 100644
GIT binary patch
delta 3550
zcmeI#JC4&p0LJn0BZ=cj9(G<zvaz7ro@&b^hLvy>A$B`fN(V@k&=2AOQ0x`x*aqzp
zxCWPi3k>p%C&~W^NbWL;Kl%I3#52j?^7q@YxG8S$o(bWUKf~-I+J3t`+-weSzP$YU
zczJQ<$mgF9uU_AZ@7eBS_&JUINGY+~mxVB|o!!1%i!`p@58d6q+}MG)+m~CBCVs4x
zBdW~$II2<`k@n1II=4Lyt7K7MD_tGk)I(QC?X|9n7IoAWI%;p@>7=dT>7>2XGs$(G
z^i0y;#n(w)LB>k?I%===P1M%+P1N3|1!)V?7Nsqdw9+=9?HVf0B(*7RQ`&*F18IlS
z4yD0K8Y>k58dOPnTBv~1E~H&ZyOee*4IvF{sey)shLX|<(g@Os(umR+(iqa%B<+&M
zXV7Z>6G#(C6G{_Gdyw`Z?NQnzv|mG|d4T$m_9^XCI)HQl>44I~nKV{v2<Wg%%HymI
zDIHRpLYhLFQkqhl)lvh^0L_Hdn}dD!GD=5~jvyUTI-+z8=~yT2@{iA<QdQ&g9ccpT
z1kwqm6H2F$P9dF|q=il`^vX=j4AL2-GfHQ*^!`_HE$xmrN6k5F&RKJTnhVriu;#+n
zG%c5CxfIS*v+L`9e#x3kTk}Wv`n|2WLd_Lxu2?fi%^Wpz*350q`#-A>IO5*r%@Nle
oamPo$IpXxswdRP^J63bV>2E`G#F>99dNTfpBX08e;>m;m5BYsr8UO$Q

delta 354
zcmcbU_Q{*eCD<k8lPUuP<Nb|X!m`|c$}#c5PVv!AuF9J=WGxx%9XR6yf<hPygqRu<
z3K$X>`LRz;<Z39WO5|c<NGhl<N=#zlVrEEQATT+Zp+Ja}g@M7x&)bC|1th=-7jR@q
zSs*w$nTrW7;sh08hKo2eq!iRvCUFTcaR2|$(2>HxP*9yH$i>Xik;2GOkkXNm$WWTN
XBw_M0)oc`J%BT%SXKtRQcZdZ54M$#(

diff --git a/tests/data/acpi/x86/q35/DSDT.viot b/tests/data/acpi/x86/q35/DSDT.viot
index 64e81f571120e3eb2b8c6c9545293a78c75b7bbd..8d98dd8845a60a08df5aff27097646bea4913b75 100644
GIT binary patch
literal 14615
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

delta 518
zcmbPU^uv?OCD<k8hYAA&<CBeC!m`|6qA~HoPVv!Aj-rz_WS7)CaK;A&g)kHdF*PI<
zFeEPWW1pJH)lg8C$i>8vR8U=%n8d)v%#gf5U~)1;fe<GP1A~vBw+llGNPrP8;K-1&
zKyY$07ZY5>2`a)27jb4tDX6VX;u2us{{Nq$BZYyXpgK{Ii<zM#g^{5kr6VDcp)_$x
f!el{J85CDqs18O~D(a%T(nEI;x^lCj=`&^k(btIc

-- 
MST


