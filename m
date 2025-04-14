Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A76FC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 18:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4OG3-00059X-Ch; Mon, 14 Apr 2025 14:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u4OFi-00054v-Pr
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:09:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1u4OFg-0005hE-4M
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 14:09:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99n3t015739
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 18:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pnKztRurHcn
 IN1SWgIMfKA8sCfMtz/Nb+KW3UeBP1O0=; b=n1dFfK73r/St+ThTal1ZhFY8VUO
 VyNXmptW1kIQaUYzB5v/GKbASnnVsT7Xq5htI7ROz1oTPNH85rITCEkF5aJ3sBuq
 hOQwsldqn3I9+t6iUj+SMVJWp0BQoyTo7/j0FOs8cVSV+CloX8+cgZNVNM0zHl6k
 XZMbYljVTtaawbWshEBD4L5+16rE7lrfLKsRE73CBeuOAL/n8rWM9IoV0vaQldbk
 Wfdx1h3K5QkACf0AlF1l1N16pcNvXYt3WJkfk7nMgmqWih6ja71049ZEpLVtTpLK
 sa2JwiZuZW/RgEvRDjWvE+UM+y5gA7Z+gEzQmv/tmzVvmO+dZAFHN4hmfZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6desm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 18:09:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2242ade807fso71309125ad.2
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 11:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744654183; x=1745258983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnKztRurHcnIN1SWgIMfKA8sCfMtz/Nb+KW3UeBP1O0=;
 b=YFNQib8TvrQ1j9WOI0A9oMUzDBvY30MuhwlKyMNvXmuMmDZ7YAUZHs1HddMYWD1Cb2
 HqMB7JFtZ8rQeWoCRCu3k+P2behlOMElYzq/WnePxLdnRQWmsrY9sdp1biC6cbqGRh2N
 NLLMUC5Vh3kYXNJ1yiya9lyvDZl4Lhv/j1du6pXrVPcl+iotoAKLWbOBmBEqm9EUT80J
 cNHYlImbdJ9pszNOrd6f5l6IcwkseGE82e8Ko619XKX3PeANAlHxCEdy/fAHa4Rk63Qx
 GluMLm9aL7m52jnbA94Sy428m//PfQOYuBiMVkoSntYJIYGHuTLg3cv/QaNtGkJGOBm/
 9njQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH9u7Q/zHemCFcZCCY/reEFoUDHjaPGMjLNfe8vZsuwB1nPlgFHMErW9SSMhhz5/pwH9otsjZv9hDj@nongnu.org
X-Gm-Message-State: AOJu0Yyj6eYKUNv0oAZFMewH76v75i18DdA2STqtQWOIFYT5CqgZ/M9N
 WYy9mb3qNGJMBu6hMQPsRQw1Tx8WcomscEOrkFQt3j3jiNStMl/fZ6jfOJcxh11cfj5bTHvGHOv
 lnVcZj4EnBkpXwyB9dvnQ5GABfoftVXYmQN1OdAoagXXRNoN0Nc/Tfg==
X-Gm-Gg: ASbGncv4GSqtEyfauWuk5+omniR9KLno4Dyoe3eBKB58N/U90NpSx+ySNHP98JY32CE
 Le+yty1sbPp+o9ufEr4yfEAd4ypxfqRjPfXYcHIG7xroHfi6Q0twR+sscsD4oxnj9/kaFOb4dJa
 XNYxJ5zm0DRTtX1v2hj1PvRGzhIh4Fsr3BWcIjmPhCRMn/AZPqxDCQHuTTeeYRk3s2WqzE28fSp
 kh+ieZTryBMNAwpBtvO7hWhslYFwSJG5roQ2lPN5qEnwTJqn1Vwv0FOg7y94AjZiCgzSQvOdphU
 J8sRMWCq+usAhTQ/F1RnTpg2qfR2lqQeDf9gcR9bNkCkFYCiH83Bj+FHWgr2FCUXndmnwV4jDWo
 =
X-Received: by 2002:a17:902:ac90:b0:224:192a:9154 with SMTP id
 d9443c01a7336-22bea4bd78amr142475435ad.26.1744654183262; 
 Mon, 14 Apr 2025 11:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMojaxqiqNK1gusObqUhBB0jo276sbA8r0EDEGt+TdJ//Sfb1qU3qapat9NDx/wf0SGimtfA==
X-Received: by 2002:a17:902:ac90:b0:224:192a:9154 with SMTP id
 d9443c01a7336-22bea4bd78amr142475175ad.26.1744654182736; 
 Mon, 14 Apr 2025 11:09:42 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c388fsm7159918b3a.54.2025.04.14.11.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 11:09:42 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: ltaylorsimpson@gmail.com
Cc: brian.cain@oss.qualcomm.com, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com
Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
Date: Mon, 14 Apr 2025 11:09:39 -0700
Message-Id: <20250414180939.3575845-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <058801dbad61_68ff5b00_3afe1100_@gmail.com>
References: <058801dbad61_68ff5b00_3afe1100_@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WG4CjUVcRJ46TN_W7QdAxabu1NAerjJe
X-Proofpoint-GUID: WG4CjUVcRJ46TN_W7QdAxabu1NAerjJe
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67fd4f68 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=WC4i52u04ZRiYehVJSoA:9 a=324X-CrmTo6CU4MGRt3R:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 mlxlogscore=768 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

On Mon, 14 Apr 2025 11:19:38 -0600 <ltaylorsimpson@gmail.com> wrote:
>
> > -----Original Message-----
> > From: Brian Cain <brian.cain@oss.qualcomm.com>
> > Sent: Monday, April 7, 2025 1:27 PM
> > To: qemu-devel@nongnu.org
> > Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> > philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> > anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> > alex.bennee@linaro.org; quic_mburton@quicinc.com;
> > sidneym@quicinc.com
> > Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
> > 
> > We should raise an exception in the event that we encounter a packet that
> > can't be correctly decoded, not fault.
> > 
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  target/hexagon/decode.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c index
> > b5ece60450..1db7f1950f 100644
> > --- a/target/hexagon/decode.c
> > +++ b/target/hexagon/decode.c
> > @@ -489,7 +489,6 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t
> > encoding)
> >              insn->iclass = iclass_bits(encoding);
> >              return 1;
> >          }
> > -        g_assert_not_reached();
> >      } else {
> >          uint32_t iclass = get_duplex_iclass(encoding);
> >          unsigned int slot0_subinsn = get_slot0_subinsn(encoding); @@ -512,6
> > +511,11 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t encoding)
> >          }
> >          g_assert_not_reached();
> 
> Why leave this one rather than raising an exception?

Good point. I think this one should be removed as well. We have removed it
downstream already.

> >      }
> > +    /*
> > +     * invalid/unrecognized opcode; return 1 and let gen_insn() raise an
> > +     * exception when it sees this empty insn.
> > +     */
> > +    return 1;
> 
> You should set insn->generate to NULL if you want to guarantee that gen_insn
> will raise an exception.

The caller already memset's it to 0 before passing `insn` down.
 
> Do you have a test case for this?

We do have a softmmu test for this downstream. Maybe we can adjust it for
user-mode and upstream it with this patch.

